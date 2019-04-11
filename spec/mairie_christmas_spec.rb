require_relative '../lib/mairie_christmas'

describe "the industrialize function" do
  it "should return client, and client is not nil" do
    expect(industrialize("https://www.annuaire-des-mairies.com/val-d-oise.html")).not_to be_nil
  end
end
  # it "should return a hash with the city and the email adress" do
  #   expect(industrialize("https://www.annuaire-des-mairies.com/val-d-oise.html")[5]["ARGENTEUIL"]).to eq({"ARGENTEUIL"=>"christian.bournery@ville-argenteuil.fr"})
  #   expect(get_townhall_email(get_townhall_urls("https://www.annuaire-des-mairies.com/val-d-oise.html"))[179]["VILLERON"]).to eq({"VILLERON"=>"accueilvilleron@roissy-online.com"})
  # end

describe "the get_townhall_email function" do
  it "should return valid emails" do
    expect(get_townhall_email(get_townhall_urls("https://www.annuaire-des-mairies.com/val-d-oise.html"))).should include("mairie.amenucourt@wanadoo.fr")
    expect(get_townhall_email(get_townhall_urls("https://www.annuaire-des-mairies.com/val-d-oise.html"))).should include("mairiefremecourt@orange.fr")
    expect(get_townhall_email(get_townhall_urls("https://www.annuaire-des-mairies.com/val-d-oise.html"))).should include("communication@ville-osny.fr")
  end
end
