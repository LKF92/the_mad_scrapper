require 'nokogiri'
require 'pry'
require 'open-uri'

### On récupère les urls qui donnent les infos de chaque mairie (=> array)
def get_townhall_urls(annuaire)
  page = Nokogiri::HTML(open(annuaire))
  array_of_urls = page.xpath('//*[@class="lientxt"]').map do
    |email| "https://www.annuaire-des-mairies.com" + email["href"][1..-1]
  end
  return array_of_urls
end


# ### On récupère le nom des mairies (=> array)
def get_townhall_name(annuaire)
  page = Nokogiri::HTML(open(annuaire))
  array_of_townhall_name = page.xpath('//*[@class="lientxt"]').map do
    |email| email.text
  end
  return array_of_townhall_name
end


# ### On récupère les addresse mail des la mairie (=> array)
def get_townhall_email(townhall_urls)
  array_of_emails = []
  townhall_urls.each do |url|
    page = Nokogiri::HTML(open(url))
    array_of_emails << page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  end
  return array_of_emails
end


def industrialize(annuaire)
  # appel de la fonction qui renvoit un array d'url
  array_of_urls = get_townhall_urls(annuaire)

  # fonction qui renvoit les noms des villes
  array_of_townhall_name = get_townhall_name(annuaire)

  #fonction qui renvoit un array d'email
  array_of_emails = get_townhall_email(array_of_urls)

  #hash avec le nom des villes en clé, et les mails en valeur. Enfin on split en minihash
  christmas_hash = array_of_townhall_name.zip(array_of_emails).to_h
  return christmas_hash.each_slice(1).map(&:to_h)
end


puts industrialize("https://www.annuaire-des-mairies.com/val-d-oise.html")
