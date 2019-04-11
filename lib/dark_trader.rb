require 'nokogiri'
require 'pry'
require 'open-uri'

page = Nokogiri::HTML(open('https://coinmarketcap.com/fr/')



cryptocurrencies = page.xpath('/html/body/div[2]/div/div[1]/div[3]/div/div[2]/div/table/tbody/tr[1]/td[2]/a[1]')
cryptocurrencies.each do |crypto|
    puts crypto.text
binding.pry
end
