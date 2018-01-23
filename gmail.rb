require 'google_drive'
require 'gmail'
require 'dotenv'
require 'pry'
Dotenv.load

# On lie la feuille townhall-upload qui récupère les informations depuis une autre page
require_relative 'townhall-upload'

# On configure le compte Gmail d'où partent les mails
$gmail = Gmail.connect!(ENV['USERNAME'], ENV['PASSWORD'])

# On configure la méthode qui envoie les mails
def send_mails
  i = 30

# On itère sur la taille du googlesheet obtenu  
#  while i < $data.size + 1
  while i < 35

    $gmail.deliver do
      to $ws[i,2]
      subject "Voulez-vous former les citoyens de " + $ws[i,1] + " au code ?"
      text_part do
        body "Text of plaintext message."
      end
      html_part do
      content_type 'text/html; charset=UTF-8'

# On appelle la méthode my_html_mail qui va chercher le texte    
      body my_html_mail($ws[i,1])
      end

    end
  i += 1

# On met un petit sleep pour ne pas trop spammer nos chères mairies  
  sleep(60)
  end
end

# On écrit ici le contenu du mail pour ne pas surcharger le code principal
def my_html_mail(name)

      "<p> Bonjour</p>
      <p> Je voudrais vous parler d'une formation que je suis actuellement, <strong> The Hacking Project</strong>. </p>
      <p> Il permet de se former <strong> gratuitement </strong> au langage informatique en 3 mois. </p>
      <p> Si vous pensez que cela pourrait vous intéresser à #{name}, je pense que vous avez raison :) </p>
      <p> Pour plus d'info, je vous conseille d'aller jeter un coup d'oeil <a href='https://www.thehackingproject.org'> par ici ! </a> </p>
      <p> Bonne journée ! </p>
      <p> Lucy </p>"
end

send_mails
