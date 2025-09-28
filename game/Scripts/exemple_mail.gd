extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	"""
	Description : Cette fonction est appelée lors de l'initialisation du noeud dans l'arbre de scène pour la première fois afin de réinitialiser les valeurs des variables et des labels.

	Arguments :
		None
	
	Retour :
		None
	"""
	#Expediteur du mail
	$HBoxContainer/NomExpediteurMail.text = ""
	#date du mail 
	$HBoxContainer/DateRecuMail.text += ""
	#le contenu du mail est à mettre ici
	$HBoxContainer/ContenuMail.text = ""



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	"""
	Description : Cette fonction est appelée lorsqu'on appuie sur le bouton de l'interface graphique afin de rendre visible ou invisible le contenu du mail.

	Arguments :
		None
	
	Retour :
		None
	"""
	$HBoxContainer/ContenuMail/PageTexteDuMail.visible = !$HBoxContainer/ContenuMail/PageTexteDuMail.visible


func _on_texte_du_mail_close_requested() -> void:
	"""
	Description : Cette fonction est appelée lorsqu'on appuie sur le bouton de fermeture de l'interface graphique afin de rendre invisible le contenu du mail.
	
	Arguments :
		None
	
	Retour :
		None
	"""
	$HBoxContainer/ContenuMail/PageTexteDuMail.hide()
