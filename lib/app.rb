require 'rubygems'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open(http://ruby.bastardsbook.com/files/hello-webpage.html))
news_links = page.css('div#references a')
news_links.each do |link|
  news_links.each{|link| puts "#{link.text}\t#{link['href']}"}
end
