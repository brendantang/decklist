require 'net/http'
require 'json'
require 'pp'

class String
  def is_integer?
     /\A[-+]?\d+\z/ === self
  end
end

class Decklist
  attr_accessor :cards
  def initialize(decklist_string)
    @string = decklist_string
    @cards = [] 
    @mainboard = []
    @sideboard = []
    self.parse_string
    self.get_card_data 
    self.separate_boards
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
        if line[0].is_integer?
          card_hash["quantity"] = line[0]
        else
          card_hash["quantity"] = 1
        end
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
    # add card data to @cards:
    @cards.each_with_index do |card, index|
      @cards[index] = card.merge(response_hash["data"][index])
    end 
  end
  
  def separate_boards  
    @cards.each do |card|
      if card["board"] == "main"
        @mainboard << card
      elsif card["board"] == "side"
        @sideboard << card
      end
    end #TODO: more concise
  end

  def display
    puts "Mainboard:"
    @mainboard.each do |card|
      string = "#{card["quantity"]}  #{card["name"]} #{card["mana_cost"]}"
      puts string
    end
    puts "Sideboard:"
    @sideboard.each do |card|
      string = "#{card["quantity"]}  #{card["name"]}"
      puts string
    end
  end
end


deck_path = ARGV
deck_string = File.open(ARGV[0])
decklist = Decklist.new(deck_string)
decklist.display
