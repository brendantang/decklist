# Read plaintext decklist and output pretty version

require 'net/http'
require 'json'
require 'pp'

class Card
  def initialize(name)
    @name = name
    @data = JSON.parse(Net::HTTP.get(URI("https://api.scryfall.com/cards/named?fuzzy=#{name}")))
  end
  
  def display
    string = "#{@data["name"]} #{@data["mana_cost"]} $#{@data["usd"]} #{@data["tix"]} tix"
    puts string
  end
end


def get_card_data(decklist_array)
  identifiers_array = []
  decklist_array.each do |name|
    identifiers_array << {"name" => name}
  end
  
  query_hash = {"identifiers" => identifiers_array}
  
  json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
  uri = URI.parse("https://api.scryfall.com/cards/collection")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  response = http.post(uri.path, query_hash.to_json, json_headers)
  card_data_hash = JSON.parse(response.body)
end

decklist_array = ["lightning bolt", "mountain", "lava spike", "searing blaze", "eidolon of the great revel", "searing blood", "monastery swiftspear", "bedlam reveler", "harsh mentor", "bomat courier", "thoughtseize"]

pp get_card_data(decklist_array)
