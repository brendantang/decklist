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

fireball = Card.new("fireball")
fireball.display
