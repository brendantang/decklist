# Read plaintext decklist and output pretty version

require 'net/http'
require 'json'
require 'pp'

class Decklist
  attr_accessor :cards
  def initialize(array)
    @array = array
    @cards = {}
    self.get_card_data 
  end
  
  def get_card_data
    identifiers_array = []
    @array.each do |name|
      identifiers_array << {"name" => name}
    end
    
    query_hash = {"identifiers" => identifiers_array}
    
    json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
    uri = URI.parse("https://api.scryfall.com/cards/collection")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.post(uri.path, query_hash.to_json, json_headers)
    response_hash = JSON.parse(response.body)
    @cards = response_hash["data"]
  end
  
  def display
    @cards.each do |card|
      string = "#{card["name"]}  #{card["mana_cost"]}  #{card["usd"]}"
      puts string
    end
  end
end

decklist_array = ["lightning bolt", "mountain", "lava spike", "searing blaze", "eidolon of the great revel", "searing blood", "monastery swiftspear", "bedlam reveler", "harsh mentor", "bomat courier", "thoughtseize"]

decklist = Decklist.new(decklist_array)
decklist.display
