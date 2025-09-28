extends Window

var selectedSecteur = null
var secteurList = ItemList.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	"""
	Description : Cette fonction est appelée lors de la création de la fenêtre de création de formation afin de créer les différents éléments graphiques et les ajouter à la fenêtre.

	Arguments :
		None
	
	Retour :
		None
	"""
	var lblEnseignant = Label.new()
	lblEnseignant.text="Nombre d'enseignants :"
	lblEnseignant.position = Vector2(10,700)
	
	var lblPlace = Label.new()
	lblPlace.text="Nombre de places :"
	lblPlace.position = Vector2(10,810)
	
	# Create a new Panel node
	var panelSelection = Panel.new()
	panelSelection.size= Vector2(780,870)
	panelSelection.position = Vector2(0,0)
	add_child(panelSelection)
	
	var lblSecteurCree= Label.new()
	lblSecteurCree.text =("Secteur en création : ")
	lblSecteurCree.position = Vector2(130,50)
	panelSelection.add_child(lblSecteurCree)
	
	var lblSecteur1 = Label.new()
	lblSecteur1.text = ("[Secteur]")
	lblSecteur1.position = Vector2(300,50)
	
	panelSelection.add_child(lblSecteur1)
	
	var leEnseignant1 = LineEdit.new()
	leEnseignant1.size = Vector2(200,50)
	leEnseignant1.position = Vector2(200,690)
	panelSelection.add_child(leEnseignant1)
	
	var lePlace1 = LineEdit.new()
	lePlace1.size = Vector2(200,50)
	lePlace1.position = Vector2(200,800)
	panelSelection.add_child(lePlace1)
	
	panelSelection.add_child(lblEnseignant)
	panelSelection.add_child(lblPlace)
	
	var btnValidate1= Button.new()
	btnValidate1.icon = load("res://Images/Add.png")
	btnValidate1.size = Vector2(40,40)
	btnValidate1.position = Vector2(730,820)
	panelSelection.add_child(btnValidate1)
	#SAVE
	
	var panelProposition = Panel.new()
	panelProposition.size= Vector2(780,870)#720/3 = 240
	panelProposition.position = Vector2(780,0)
	add_child(panelProposition)


	panelProposition.add_child(secteurList)
	
	for secteur in secteurs_specialities:
		# Add the sector title
		secteurList.size = Vector2(780,870)
		secteurList.add_item("                                                       Formation : "+secteur["titre"],null,false)
		
		# Add the specialities of the sector
		for speciality in secteur["specialities"]:
			secteurList.add_item(speciality["titre"],null,true)
			
			secteurList.item_selected.connect(func (index: int):
				lblSecteur1.text = secteurList.get_item_text(index)
			)
	
	btnValidate1.pressed.connect(func ():
		if !secteurList.get_selected_items().is_empty() and leEnseignant1.text != "" and lePlace1.text != "" and _is_only_numbers(leEnseignant1.text) and _is_only_numbers(lePlace1.text) and lblSecteur1.text != "[Secteur]":
			_add_formation(lblSecteur1.text, leEnseignant1.text, lePlace1.text, secteurList.get_selected_items()[0])
			_check_formation_equal_mail_demand(secteurList.get_selected_items()[0])

			leEnseignant1.clear()
			lePlace1.clear()
			lblSecteur1.text="[Secteur]"
			selectedSecteur = null
	)
	
	var btnDelete1= Button.new()
	btnDelete1.icon = load("res://Images/Delete.png")
	btnDelete1.size = Vector2(40,40)
	btnDelete1.position = Vector2(680,820)
	panelSelection.add_child(btnDelete1)
	btnDelete1.pressed.connect(func ():
		leEnseignant1.clear()
		lePlace1.clear()
		lblSecteur1.text="[Secteur]"
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_about_to_popup() -> void:
	pass

var secteurs_specialities = [
	{
		"id": 1,
		"titre": "Informatique",
		"croissance": 1,
		"popularite": 2,
		"specialities": [
			{ "titre": "Développement mobile", "nbPlaces": 90, "nbEnseignants": 20, "tauxReussite": 83 },
			{ "titre": "Développement web", "nbPlaces": 90, "nbEnseignants": 20, "tauxReussite": 83 },
			{ "titre": "Big data", "nbPlaces": 90, "nbEnseignants": 20, "tauxReussite": 83 },
			{ "titre": "IA", "nbPlaces": 90, "nbEnseignants": 20, "tauxReussite": 83 },
			{ "titre": "Automates", "nbPlaces": 90, "nbEnseignants": 20, "tauxReussite": 83 }
		]
	},
	{
		"id": 2,
		"titre": "Médecine",
		"croissance": 1,
		"popularite": 2,
		"specialities": [
			{ "titre": "Chirurgien", "nbPlaces": 25, "nbEnseignants": 10, "tauxReussite": 29 },
			{ "titre": "Cardiologie", "nbPlaces": 30, "nbEnseignants": 12, "tauxReussite": 35 },
			{ "titre": "Pédiatrie", "nbPlaces": 20, "nbEnseignants": 8, "tauxReussite": 40 },
			{ "titre": "Radiologie", "nbPlaces": 15, "nbEnseignants": 6, "tauxReussite": 25 },
			{ "titre": "Gynécologie", "nbPlaces": 22, "nbEnseignants": 9, "tauxReussite": 38 }
		]
	},
	{
		"id": 3,
		"titre": "Automobile",
		"croissance": -1,
		"popularite": 0,
		"specialities": [
			{ "titre": "Ingénierie automobile", "nbPlaces": 40, "nbEnseignants": 15, "tauxReussite": 50 },
			{ "titre": "Design automobile", "nbPlaces": 35, "nbEnseignants": 12, "tauxReussite": 45 },
			{ "titre": "Mécanique automobile", "nbPlaces": 30, "nbEnseignants": 10, "tauxReussite": 55 },
			{ "titre": "Électronique embarquée", "nbPlaces": 25, "nbEnseignants": 8, "tauxReussite": 60 },
			{ "titre": "Systèmes de propulsion", "nbPlaces": 20, "nbEnseignants": 7, "tauxReussite": 65 }
		]
	},
	{
		"id": 4,
		"titre": "Finance",
		"croissance": 0,
		"popularite": 2,
		"specialities": [
			{ "titre": "Gestion de portefeuille", "nbPlaces": 40, "nbEnseignants": 18, "tauxReussite": 75 },
			{ "titre": "Analyse financière", "nbPlaces": 35, "nbEnseignants": 15, "tauxReussite": 70 },
			{ "titre": "Banque d'investissement", "nbPlaces": 30, "nbEnseignants": 12, "tauxReussite": 80 },
			{ "titre": "Comptabilité avancée", "nbPlaces": 25, "nbEnseignants": 10, "tauxReussite": 65 },
			{ "titre": "Fiscalité internationale", "nbPlaces": 20, "nbEnseignants": 8, "tauxReussite": 85 }
		]
	},
	{
		"id": 5,
		"titre": "Agriculture",
		"croissance": -1,
		"popularite": 1,
		"specialities": [
			{ "titre": "Agronomie", "nbPlaces": 40, "nbEnseignants": 20, "tauxReussite": 80 },
			{ "titre": "Horticulture", "nbPlaces": 35, "nbEnseignants": 18, "tauxReussite": 75 },
			{ "titre": "Élevage bovin", "nbPlaces": 30, "nbEnseignants": 15, "tauxReussite": 70 },
			{ "titre": "Viticulture", "nbPlaces": 25, "nbEnseignants": 12, "tauxReussite": 65 },
			{ "titre": "Agroforesterie", "nbPlaces": 20, "nbEnseignants": 10, "tauxReussite": 60 }
		]
	}
]
func _on_visibility_changed() -> void:
	pass

func _add_formation(secteur, enseignant, place, item_index) -> void:
	"""
	Description : Cette fonction est appelée lorsqu'on appuie sur le bouton de validation pour ajouter une formation à la liste des formations existantes.

	Arguments :
		secteur : String : le secteur de la formation.
		enseignant : String : le nombre d'enseignants de la formation.
		place : String : le nombre de places de la formation.
		item_index : int : l'index de l'item sélectionné dans la liste des secteurs.
	
	Retour :
		None
	"""
	if secteur == "[Secteur]" or enseignant == "" or place == "":
		return

	if item_index < 6:
		selectedSecteur = "Informatique"
	elif item_index < 12:
		selectedSecteur = "Médecine"
	elif item_index < 18:
		selectedSecteur = "Automobile"
	elif item_index < 24:
		selectedSecteur = "Finance"
	elif item_index < 30:
		selectedSecteur = "Agriculture"

	var path = "user://Data/FormationExistante.json"

	var file = FileAccess.open(path, FileAccess.READ_WRITE)
	var file_content = file.get_as_text()
	var file_json = JSON.parse_string(file_content)

	var id = 0

	for block in file_json:
		if typeof(block) == TYPE_DICTIONARY and "id" in block:
			id += 1
	
	#Croissance random
	
	
	var new_formation = {
		"id": id,
		"formation": selectedSecteur,
		"croissance": "Neutre",
		"popularite": "Moyennement populaire",
		"specialities": {
			"titre": secteur,
			"nbEtudiants": int(0),
			"nbPlaces": int(place),
			"nbEnseignants": int(enseignant),
			"tauxReussite": int(0)
		}
	}
	
	file_json.append(new_formation)

	file.store_string(JSON.stringify(file_json))

	file.close()
	
func _update_formation(id,nbPlaces,nbEnseignants)->void:
	"""
	Description : Cette fonction est appelée lorsqu'on appuie sur le bouton de validation pour mettre à jour une formation existante.

	Arguments :
		id : int : l'identifiant de la formation à mettre à jour.
		nbPlaces : String : le nombre de places de la formation.
		nbEnseignants : String : le nombre d'enseignants de la formation.
	
	Retour :
		None
	"""
	var path = "user://Data/FormationExistante.json"
	var file = FileAccess.open(path, FileAccess.READ_WRITE)
	var file_content = file.get_as_text()
	var file_json = JSON.parse_string(file_content)
	file.close()
	
	for formation in file_json:
		if formation.id == id:
			# Mettre à jour les champs nécessaires
			formation.specialities.nbPlaces = int(nbPlaces)
			formation.specialities.nbEnseignants = int(nbEnseignants)
			
				# Sauvegarder les modifications dans le fichier
	file.seek(0)  # Revenir au début du fichier
	file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(file_json))
	file.close()
	
	


func _on_texture_button_pressed() -> void:
	"""
	Description : Cette fonction est appelée lorsqu'on appuie sur le bouton de l'interface graphique afin d'actualiser les données des différentes formations lorsque l'on passe à l'année suivante.

	Arguments :
		None
	
	Retour :
		None
	"""
	var path = "user://Data/FormationExistante.json"
	var file = FileAccess.open(path, FileAccess.READ)
	var file_content = file.get_as_text()
	var file_json = JSON.parse_string(file_content)

	file.close()
	if not typeof(file_json) in [TYPE_ARRAY, TYPE_DICTIONARY]:
		return

	
	var moyenneTauxReussite =0
	var nbFormation = 0
	
	for formation in file_json:
		if formation.id == nbFormation && formation.specialities.tauxReussite ==0 :
			_actualise_formation(formation.id,file_json)
			break

		if formation.specialities.nbEtudiants !=0 :
			formation.specialities.nbEtudiants = int(formation.specialities.nbEtudiants + (randi_range(-formation.specialities.nbEtudiants/20,formation.specialities.nbEtudiants/20)))
		if formation.specialities.nbEtudiants > formation.specialities.nbPlaces :
			formation.specialities.nbEtudiants = formation.specialities.nbPlaces

				
		var ratio = float(formation.specialities.nbEnseignants) / formation.specialities.nbEtudiants
		var modifierReussite
		if ratio < 0.001:
			modifierReussite = -20000000000.0	# si le ratio est inférieur à 0.1%, on baisse fortement le taux de réussite
		elif ratio < 0.005:
			modifierReussite = - 100  			# si le ratio est inférieur à 0.5%, on baisse fortement le taux de réussite
		elif ratio < 0.01:
			modifierReussite = -20.0			# si le ratio est inférieur à 1%, on baisse fortement le taux de réussite
		elif ratio < 0.02:
			modifierReussite = -7.5  			# si le ratio est inférieur à 2%, on baisse fortement le taux de réussite
		elif ratio < 0.025:
			modifierReussite = -6.0  			# si le ratio est compris entre 2 et 2.5%, on baisse fortement le taux de réussite
		elif ratio < 0.03:
			modifierReussite = -4.5  			# si le ratio est compris entre 2.5 et 3%, on baisse le taux de réussite
		elif ratio < 0.035:
			modifierReussite = -3.0  			# si le ratio est compris entre 3 et 3.5%, on baisse le taux de réussite
		elif ratio < 0.04:
			modifierReussite = -1.5  			# si le ratio est compris entre 3.5 et 4%, on baisse légèrement le taux de réussite
		elif ratio < 0.045:
			modifierReussite = 0.0   			# si le ratio est compris entre 4 et 4.5%, on ne change pas le taux de réussite
		elif ratio < 0.05:
			modifierReussite = 1.5   			# si le ratio est compris entre 4.5 et 5%, on augmente légèrement le taux de réussite
		elif ratio < 0.055:
			modifierReussite = 3.0   			# si le ratio est compris entre 5 et 5.5%, on augmente le taux de réussite
		elif ratio < 0.06:
			modifierReussite = 4.5   			# si le ratio est compris entre 5.5 et 6%, on augmente le taux de réussite
		elif ratio < 0.065:
			modifierReussite = 6.0   			# si le ratio est compris entre 6 et 6.5%, on augmente fortement le taux de réussite
		elif ratio < 0.07:
			modifierReussite = 7.5   			# si le ratio est compris entre 6.5 et 7%, on augmente fortement le taux de réussite
		elif ratio < 0.075:
			modifierReussite = 6.0   			# si le ratio est compris entre 7 et 7.5%, on augmente fortement le taux de réussite
		elif ratio < 0.08:
			modifierReussite = 4.5   			# si le ratio est compris entre 7.5 et 8%, on augmente le taux de réussite
		elif ratio < 0.085:
			modifierReussite = 3.0   			# si le ratio est compris entre 8 et 8.5%, on augmente le taux de réussite
		elif ratio < 0.09:
			modifierReussite = 1.5   			# si le ratio est compris entre 8.5 et 9%, on augmente légèrement le taux de réussite
		elif ratio < 0.095:
			modifierReussite = 0.0   			# si le ratio est compris entre 9 et 9.5%, on ne change pas le taux de réussite
		elif ratio < 0.1:
			modifierReussite = -1.5  			# si le ratio est compris entre 9.5 et 10%, on baisse légèrement le taux de réussite
		elif ratio < 0.105:
			modifierReussite = -3.0  			# si le ratio est compris entre 10 et 10.5%, on baisse le taux de réussite
		elif ratio < 0.11:			
			modifierReussite = -4.5  			# si le ratio est compris entre 10.5 et 11%, on baisse le taux de réussite
		elif ratio < 0.115:
			modifierReussite = -6.0  			# si le ratio est compris entre 11 et 11.5%, on baisse fortement le taux de réussite
		elif ratio < 0.2:
			modifierReussite = -7.5  			# si le ratio est compris entre 11.5% et 20%, on baisse fortement le taux de réussite
		else:
			modifierReussite = -20000000000.0	# si le ratio est supérieur à 20%, on baisse fortement le taux de réussite
		
		var randomReussite = randi_range(45, 55) + modifierReussite * ratio * 100
		if randomReussite > 100:
			randomReussite = 99
		if randomReussite < 0:
			randomReussite = 1

		formation.specialities.tauxReussite = int(randomReussite)
			
		nbFormation +=1
		moyenneTauxReussite+= int(formation.specialities.tauxReussite)
				
	$"../../barTauxReussite".value = float(moyenneTauxReussite) / nbFormation

	file = FileAccess.open(path, FileAccess.WRITE)
	file.seek(0)  # Revenir au début du fichier
	file.store_string(JSON.stringify(file_json))
	file.flush()
	file.close()
	
	var path_mail_existant = "user://Data/MailExistant.json"
	var file_mail_existant = FileAccess.open(path_mail_existant, FileAccess.READ_WRITE)
	var content_mail_existant = file_mail_existant.get_as_text()
	var data_mail_existant = JSON.parse_string(content_mail_existant)
	
	var mail_count = 0
	for mail in data_mail_existant :
		if mail.id != 0 :
			mail_count+=1
	
	if mail_count < 2 :
		$"../../PanelMail/PageMail/PanelFondgris/ScrollContainer/VBoxContainer"._add_new_mail()


func _actualise_formation(id,file_json)->void:
	"""
	Description : Cette fonction est appelée par _on_texture_button_pressed() pour actualiser une formation existante qui n'avait pas encore été initialisée.

	Arguments :
		id : int : l'identifiant de la formation à actualiser.
		file_json : Dictionary : le contenu du fichier JSON contenant les formations.
	
	Retour :
		None
	"""
	randomize() # Initialise le générateur aléatoire
	var randomCroissance = randi_range(-1,1)
	#Popularité random
	var randomPop = randi_range(-2,2)
	#Modifier qui va appliquer au nbEtudiants inscrits
	var modifierEtu =0.6
	#En fonction croissance
	if randomCroissance == -1:
		modifierEtu *=0.8
	if randomCroissance == 1:
		modifierEtu *= 1.2
		
	#En fonction Popularité
	if randomPop == -2:
		modifierEtu *=0.65
	if randomPop == -1:
		modifierEtu *=0.8
	if randomPop == 1:
		modifierEtu *=1.25
	if randomPop == 2:
		modifierEtu *=1.45
	

	#Etudiant en fonction de la Popularité et Croissance < place
	var nbPlaces = 0
	var nbEnseignants = 0
	for formation in file_json:
		if formation.id == int(id) :
			nbPlaces = formation.specialities.nbPlaces
			nbEnseignants = formation.specialities.nbEnseignants
	
	var randomEtu
	randomEtu = nbPlaces * modifierEtu
	if randomEtu > int(nbPlaces):
		randomEtu = int(nbPlaces)
	if randomEtu <= 0:
		randomEtu = 1
	# 50 +  random (-20,20)
	
	var modifierReussite =1
		#En fonction d'enseignant
	if float(nbEnseignants)/randomEtu <0.04 :
		modifierReussite = -1
		
	var randomReussite = randi_range(40,50) + modifierReussite * float(nbEnseignants)/randomEtu*100
	randomReussite *= modifierReussite
	
	if randomReussite > 100:
		randomReussite = 99
	if randomReussite < 0:
		randomReussite = 1
	
	if randomCroissance == 0:
		randomCroissance = "Neutre"
	elif randomCroissance == 1:
		randomCroissance = "Positive"
	else:
		randomCroissance = "Négative"

	if randomPop == 0:
		randomPop = "Moyennement populaire"
	elif randomPop == 1:
		randomPop = "Très populaire"
	elif randomPop == 2:
		randomPop = "Extrêmement populaire"
	elif randomPop == -1:
		randomPop = "Peu populaire"
	else:
		randomPop = "Pas populaire"
	
	for formation in file_json:
		if formation.id == id:
			# Mettre à jour les champs nécessaires
			formation.croissance = randomCroissance
			formation.popularite = int(randomPop)
			formation.specialities.nbEtudiants = int(randomEtu)
			formation.specialities.tauxReussite = int(randomReussite)


func _is_only_numbers(input: String) -> bool:
	"""
	Description : Cette fonction est appelée pour vérifier si une chaîne de caractères ne contient que des chiffres.

	Arguments :
		input : String : la chaîne de caractères à vérifier.
	
	Retour :
		bool : True si la chaîne ne contient que des chiffres, False sinon.
	"""
	var regex = RegEx.new()
	regex.compile("^[0-9]+$")  # Motif : seulement des chiffres
	return regex.search(input) != null
	
func _check_formation_equal_mail_demand(item_index) ->void:
	if item_index < 6:
		selectedSecteur = "Informatique"
	elif item_index < 12:
		selectedSecteur = "Médecine"
	elif item_index < 18:
		selectedSecteur = "Automobile"
	elif item_index < 24:
		selectedSecteur = "Finance"
	elif item_index < 30:
		selectedSecteur = "Agriculture"
	var formation_bon=false
	var mail_to_modif=null
	var path = "user://Data/MailExistant.json"
	var file = FileAccess.open(path, FileAccess.READ_WRITE)
	var file_content = file.get_as_text()
	var file_json = JSON.parse_string(file_content)
	file.close()

	for mail in file_json :
		mail_to_modif = mail
		if mail.has("formation") and selectedSecteur == mail["formation"]:
			formation_bon = true
			mail.id = 0
			#mail.content = ""
			mail.content = "Merci ! Vous avez créé la bonne formation ["+mail.formation+"]"
			mail.formation = ""
			$"../../PanelMail/PageMail/PanelFondgris/ScrollContainer/VBoxContainer"._add_all_mail(file_json)
			break
	if !formation_bon :
		$"../../PanelMail"._add_mail_incorrect_creation(file_json,mail_to_modif)
			
	
	$"../../PanelMail".update_mail_notif()
	
	file = FileAccess.open(path, FileAccess.WRITE)
	file.seek(0)  # Revenir au début du fichier
	#file.store_string("")
	file.store_string(JSON.stringify(file_json))
	file.close
