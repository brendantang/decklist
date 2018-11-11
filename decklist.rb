# Read plaintext decklist and output pretty version

require 'net/http'
require 'json'
require 'pp'

class Decklist
  attr_accessor :cards
  def initialize(decklist_string)
    @string = decklist_string
    @list = [] 
    @card_data = {}
    self.parse_string
    self.get_card_data 
  end

  def parse_string
    @string.each_line do |line|
      card_hash = {}
      card_hash["quantity"] = line[0]
      card_hash["name"] = line[2..-1].chomp
      @list << card_hash
    end
  end

  def get_card_data
    identifiers_array = []
    @list.each do |line|
      identifiers_array << {"name" => line["name"]}
    end
    
    query_hash = {"identifiers" => identifiers_array}
    
    json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
    uri = URI.parse("https://api.scryfall.com/cards/collection")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.post(uri.path, query_hash.to_json, json_headers)
    response_hash = JSON.parse(response.body)
    @card_data = response_hash["data"]
  end
  
  def display
    @list.each_with_index do |line, index|
      # set local variable card to the corresponding item in @card_data
      card = @card_data[index]
      string = "#{line["quantity"]}  #{card["name"]}  #{card["mana_cost"]}  #{card["usd"]}"
      puts string
    end
  end
end

sample = "4 Eldrazi Displacer
4 Flickerwisp
4 Leonin Arbiter
3 Thalia, Guardian of Thraben
4 Thought-Knot Seer
3 Lingering Souls
1 Restoration Angel
1 Swamp"

decklist = Decklist.new(sample)
decklist.display
