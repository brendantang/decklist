# Read plaintext decklist and output pretty version

require 'net/http'
require 'json'
require 'pp'

fireball_uri = URI('https://api.scryfall.com/cards/named?fuzzy=fireball')
fireball_json = Net::HTTP.get(fireball_uri)
fireball = JSON.parse(fireball_json)

puts fireball["name"]
