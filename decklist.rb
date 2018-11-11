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

decklist = []
decklist_array = ["lightning bolt", "mountain"]
decklist_array.each do |card|
  decklist << Card.new(card)
end

decklist.each do |card|
  card.display
end
