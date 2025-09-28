extends VBoxContainer

var _data
var data_mail_existant

@onready var liste = []
signal new_mail_generated

# Chemin vers la scène ExempleMail
const MAIL_SCENE_PATH = "res://exemple_mail.tscn"
var mail_scene = load(MAIL_SCENE_PATH)

# Appelé lors de l'entrée dans l'arbre de scène
func _ready() -> void:
	liste = []
	for i in range(1, 31):  # De 1 à 14 inclus
		liste.append(i)

func _on_button_pressed() -> void:
	
	_add_new_mail()
	
func _add_new_mail() -> void:
	var path = "user://Data/BddMail.json"
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	var _data = JSON.parse_string(content)

	var path_mail_existant = "user://Data/MailExistant.json"
	var file_mail_existant = FileAccess.open(path_mail_existant, FileAccess.READ_WRITE)
	var content_mail_existant = file_mail_existant.get_as_text()
	var data_mail_existant = JSON.parse_string(content_mail_existant)
	
	# Vérification de la liste
	if liste.size() == 0:
		return

	# Vérifier si le premier mail (ID 1) doit être généré
	var index = randi_range(1, liste.size() - 1)
	var randid = liste[index]
	# Trouver l'email avec l'id correspondant
	for email in _data:
		if email.id == randid:
			data_mail_existant.append(email)

	_add_all_mail(data_mail_existant)
	
	file_mail_existant.seek(0) # Revenir au début du fichier
	file_mail_existant.store_string(JSON.stringify(data_mail_existant))
	file_mail_existant.close

func _add_all_mail(file_json):
	for child in get_children() :
		remove_child(child)

	for selected_email in file_json :
		var mail_instance = mail_scene.instantiate()
		add_child(mail_instance)
		var expediteur = mail_instance.get_node("HBoxContainer/NomExpediteurMail")
		var contenuMail = mail_instance.get_node("HBoxContainer/ContenuMail")
		var dateRecu = mail_instance.get_node("HBoxContainer/DateRecuMail")
		var richTextLabel = mail_instance.get_node("HBoxContainer/ContenuMail/PageTexteDuMail/RichTextLabel")
		# Positionner et ajouter l'instance dans la hiérarchie
		expediteur.text = ""  # Efface l'ancien contenu
		expediteur.text = selected_email.sender
		
		var first_line = selected_email.content.split("\n")[0] # Récupère la première ligne du contenu
		contenuMail.text = ""  # Efface l'ancien contenu
		contenuMail.text = first_line
		
		dateRecu.text = ""  # Efface l'ancien contenu
		dateRecu.text = selected_email.date_sent

		 #Mettre le texte du ContenuMail dans le RichTextLabel
		if richTextLabel:
			richTextLabel.text = selected_email.content  # Copier le contenu dans le RichTextLabel
		emit_signal("new_mail_generated")

func _mail_existant_reset() -> void:
	var path = "user://Data/BddMail.json"
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	_data = null
	_data = JSON.parse_string(content)
	data_mail_existant = []
	
	for email in _data:
		if email.id == 1:
			data_mail_existant.append(email)
	
	_add_all_mail(data_mail_existant)
	
	var path_mail_existant = "user://Data/MailExistant.json"
	var file_mail_existant = FileAccess.open(path_mail_existant, FileAccess.WRITE)
	var content_mail_existant = file_mail_existant.get_as_text()
	
	file_mail_existant.seek(0)  # Revenir au début du fichier
	file_mail_existant.store_string(JSON.stringify(data_mail_existant))
	file_mail_existant.close
