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
  i = 2

# On itère sur la taille du googlesheet obtenu  
while i < $data.size + 1

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
  sleep(30)
  end
end

# On écrit ici le contenu du mail pour ne pas surcharger le code principal
def my_html_mail(name)

      "<p> Bonjour</p>
      <p> Je voudrais vous parler d'une formation que je suis actuellement, <strong> The Hacking Project</strong>. </p>
      <p> Elle permet de se former <strong> gratuitement </strong> et à distance, à des langages informatiques. Le tout... en 3 mois !</p>
      <p> Si vous pensez que cela pourrait vous intéresser à #{name}, je pense que vous avez raison :) </p>
      <p> Pour plus d'infos, je vous conseille d'aller jeter un coup d'oeil <a href='https://www.thehackingproject.org'> par ici ! </a> </p>
      <p> Sinon, vous pouvez contacter directement Charles, le responsable de la formation, au 06.95.46.60.80 ! Il sera ravi de répondre à toutes vos questions.</p>
      <p> Très bonne journée à vous :) </p>
      <p> Lucy </p>"
end

send_mails
