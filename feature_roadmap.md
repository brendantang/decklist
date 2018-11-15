- copy relevant card data from `@card_data` to `@cards` array
  - and cache it to save memory and http requests
    - if cached data is more than 24 hrs old, pull it again
  - cache most recent decklist and load it by default if not passed another path

- make various sort methods
  - by CMC, by color, by price (should also be able to write the sort to original text file?)

- make it a package so you can keep it in your `bin` directory, pass it options, alias it, etc.
  - e.g. `deck -cmc "~/mtg/naya_burn.txt"` etc. not sure if that's exactly the best approach but i'll figure it out hehe
