def dark_trader
require 'nokogiri'
require 'pry'
require 'open-uri'

page = Nokogiri::HTML(open('https://coinmarketcap.com/fr/'))

###on récupère les cryptomonnaies
crypto_table = page.xpath('//*[@class = "currency-name-container link-secondary"]')
crypto_name = crypto_table.map{|crypto|crypto.text}

### Puis on fait la même chose pour chopper leurs valorisations
crypto_price_table = page.xpath('//*[@class = "price"]')
crypto_price = crypto_price_table.map {|price|price.text }

### ET PAF... https://www.youtube.com/watch?v=57z3JfkWiao !
crypto_hash = crypto_name.zip(crypto_price).to_h

### each_slice.map &:to_h transforme le hash global en 'mini hash'. On aurait pu découper 2 par 2 en prenant each_slice(2), etc.
return crypto_hash.each_slice(1).map &:to_h
end
