# Read plaintext decklist and output pretty version

require 'net/http'
require 'json'
require 'pp'

class Decklist
  attr_accessor :cards
  def initialize(decklist_string)
    @string = decklist_string
    @cards = [] 
    @card_data = {}
    self.parse_string
    self.get_card_data 
  end

  def parse_string
    board = "main"
    @string.each_line do |line|
      if line.chomp.downcase == "mainboard"
        board = "main"
      elsif line.chomp.downcase == "sideboard"
        board = "side"
      else
        card_hash = {}
        card_hash["quantity"] = line[0]
        card_hash["name"] = line[2..-1].chomp
        card_hash["board"] = board 
        @cards << card_hash
      end
    end
  end

  def get_card_data
    identifiers_array = []
    @cards.each do |card|
      identifiers_array << {"name" => card["name"]}
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
    @cards.each_with_index do |card, index|
      # set local variable card to the corresponding item in @card_data
      data = @card_data[index]
      string = "#{card["board"]} #{card["quantity"]}  #{data["name"]}  #{data["mana_cost"]}  #{data["usd"]}"
      puts string
    end
  end
end


deck_path = ARGV
deck_string = File.open(ARGV[0])
decklist = Decklist.new(deck_string)
decklist.display
