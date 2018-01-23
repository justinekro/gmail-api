require 'google_drive'
require_relative 'townhall-scrap'
require 'json'
require 'csv'
$data = get_hash

# On crée une méthode qui appelle drive et configure la spreadsheet

def setup_spreadsheet
  session = GoogleDrive::Session.from_config("config.json")
  $ws = session.spreadsheet_by_key("1WN56vQWArGdej3ZpgStWWiqZ6i5OARD_wvsoMvAbDi8").worksheets[0]
  $ws[1, 1] = "Mairie"
  $ws[1, 2] = "Adresse mail"
  $ws.save
end

# On crée une méthode qui récupère le hash et l'imprime sur un googledrive
def upload_hash
	setup_spreadsheet
	i = 2
	$data.keys.each do |key|
	$ws[i,1] = key
	$ws[i,2] = $data[$ws[i,1]]  
	i += 1 
	end
  $ws.save	
end
 
# On appelle la dernière méthode
upload_hash


=begin
# On enregistre le fichier en JSON
File.open("/Users/jkronovsek/Desktop/townhall.json","w") do |f|
  f.write(JSON.pretty_generate($data))
end

# On enregistre le fichier en CSV
CSV.open("/Users/jkronovsek/Desktop/townhall.csv", "w") do |csv|
  JSON.parse(File.open("/Users/jkronovsek/Desktop/townhall.json").read).each do |hashes|
   csv << hashes.values_at(0,1)
  end
end

=end


