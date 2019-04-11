require 'nokogiri'
require 'pry'
require 'open-uri'

### On récupère les urls qui donnent les infos de chaque député
def get_urls
array_of_urls = []
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  array_of_urls = page.xpath('//*[@class="clearfix col-container"]/ul/li/a').map do
    |url| "http://www2.assemblee-nationale.fr" + url["href"]
  end
  return array_of_urls
end



### On récupère le nom des députés (=> array)
def get_name
  page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  array_of_deputy_name = page.xpath('//*[@class="clearfix col-container"]/ul/li/a').map do
    |email| email.text[3..-1].strip
  end
  return array_of_deputy_name
end


### On récupère les mails des députés (=> array)
def get_email(array_of_urls)
  array_of_emails = []
  array_of_urls.each do |url|
    page = Nokogiri::HTML(open(url))
    array_of_emails << page.xpath('/html/body/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text
  end
  return array_of_emails
end


def industrialize
  # appel de la fonction qui renvoie un array d'url
  array_of_urls = get_urls

  # fonction qui renvoie les noms des villes
  array_of_deputy_name = get_name

  #fonction qui renvoie un array d'email
  array_of_emails = get_email(array_of_urls)

  #hash avec le nom des villes en clé, et les mails en valeur. Enfin on split en minihash
  deputy_hash = array_of_deputy_name.zip(array_of_emails).to_h
  return deputy_hash.each_slice(1).map(&:to_h)
end


puts industrialize
