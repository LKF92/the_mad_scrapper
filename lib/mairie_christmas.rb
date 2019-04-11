require 'nokogiri'
require 'pry'
require 'open-uri'


def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(open(townhall_url))
  single_email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
  puts single_email
end



def get_townhall_urls(annuaire)
  page = Nokogiri::HTML(open(annuaire))
  array_of_urls = page.xpath('//*[@class="lientxt"]').map do
    |email| "https://www.annuaire-des-mairies.com" + email["href"][1..-1]
  end
end

get_townhall_email(get_townhall_urls("https://www.annuaire-des-mairies.com/val-d-oise.html"))

# def industrialize(townhall_directory)
#   list_of_urls = get_townhall_urls(townhall_directory)
#   get_townhall_email(list_of_urls)
# end


# industrialize("https://www.annuaire-des-mairies.com/val-d-oise.html")
