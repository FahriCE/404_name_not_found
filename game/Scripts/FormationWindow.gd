extends Window

var utils = load("res://Scripts/formation_chose.gd").new()
var _data
var container

# Called when the node enters the scene tree for the first time.
func _ready():
	"""
	Description : Cette fonction est appelée lors de la création de la fenêtre de formation afin de charger les données des formations existantes et de configurer le container.

	Arguments :
		None
	
	Retour :
		None
	"""
	container = $FormationWindowScrollContainer/FormationWindowVBoxContainer
	container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	load_data()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_close_requested():
	hide()

func _on_window_input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ESCAPE:
				hide()

func _on_focus_entered():
	"""
	Description : Cette fonction est appelée lorsqu'on entre dans la fenêtre de formation pour recharger les données des formations existantes.

	Arguments :
		None
	
	Retour :
		None
	"""
	load_formation()

func load_data():
	"""
	Description : Cette fonction est appelée pour charger les données des formations existantes à partir du fichier JSON.

	Arguments :
		None
	
	Retour :
		None
	"""
	var path = "user://Data/FormationExistante.json"

	var file = FileAccess.open(path, FileAccess.READ)

	if file == null:
		return

	var content = file.get_as_text()
	file.close()
	
	_data = null
	_data = JSON.parse_string(content)
	
func load_formation():
	"""
	Description : Cette fonction est appelée pour charger les données des formations existantes et les afficher dans la fenêtre de formation.

	Arguments :
		None
	
	Retour :
		None
	"""
	load_data()
	while container.get_child_count() > 0:
		var child = container.get_child(0)
		container.remove_child(child)
		child.queue_free()
	
	var i = 0
	for formation in _data:
		var panelTemp = Panel.new()
		panelTemp.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		panelTemp.custom_minimum_size = Vector2(990, 200)  # Set minimum height to 200 pixels
		
		# Label of the formation title
		var labelFormationTitle = Label.new()
		labelFormationTitle.text = formation["formation"] + " : " + formation["specialities"]["titre"]
		var font = labelFormationTitle.get_theme_font_size("font_size", "Label")
		labelFormationTitle.add_theme_font_size_override("font_size", font + 5)
		panelTemp.add_child(labelFormationTitle)
		labelFormationTitle.position = Vector2(10, 10)

		# TextureButton to modify the formation
		var btnModify = TextureButton.new()
		btnModify.name = "btnModify" + str(formation["id"])
		btnModify.texture_normal = load("res://Images/gear.png")
		btnModify.position = Vector2(900, 60)

		# Ensure the texture stretches correctly
		btnModify.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		btnModify.size = Vector2(80, 80)

		# Showing growth, number of jobs, popularity, number of places, number of teachers and number of students
		var lblGrowth = Label.new()
		var lblPopularity = Label.new()
		var lblPlaces = Label.new()
		var lblTeachers = Label.new()
		var lblStudents = Label.new()

		lblGrowth.text = "Croissance : " + str(formation["croissance"])
		lblPopularity.text = "Popularité : " + str(formation["popularite"])
		lblPlaces.text = "Nombre de places : " + str(formation["specialities"]["nbPlaces"])
		lblTeachers.text = "Nombre d'enseignants : " + str(formation["specialities"]["nbEnseignants"])
		lblStudents.text = "Nombre d'étudiants : " + str(formation["specialities"]["nbEtudiants"])

		lblGrowth.position = Vector2(10, 50)
		lblPopularity.position = Vector2(200, 50)
		lblTeachers.position = Vector2(200, 80)
		lblPlaces.position = Vector2(10, 110)
		lblStudents.position = Vector2(200, 110)

		panelTemp.add_child(lblGrowth)
		panelTemp.add_child(lblPopularity)
		panelTemp.add_child(lblPlaces)
		panelTemp.add_child(lblTeachers)
		panelTemp.add_child(lblStudents)

		# Progress bar to show the success rate of the formation
		var lblProgress = Label.new()
		lblProgress.text = "Taux de réussite : "
		lblProgress.position = Vector2(10, 150)
		var progress = ProgressBar.new()
		progress.value = formation["specialities"]["tauxReussite"]
		progress.position = Vector2(150, 150)
		progress.size = Vector2(700, 30)

		panelTemp.add_child(lblProgress)
		panelTemp.add_child(progress)
		panelTemp.add_child(btnModify)
		container.add_child(panelTemp)

		# On remplace le code ci-dessous par des window codé en dur ici qui seront ajouté à la node principale du projet
		var window = Window.new()
		window.title = "Modifier la formation"
		window.visible = false
		window.size = Vector2(600, 200)  # Taille
		window.position = Vector2(200, 100)  # Position initiale

		# Ajouter un contenu (facultatif)
		var label = Label.new()
		label.text =  formation["formation"] + " : " + formation["specialities"]["titre"]
		label.position = Vector2(10, 25)
		window.add_child(label)

		# Ajout des champs pour modifier la formation
		var lblTeachersModify = Label.new()
		var lblPlacesModify = Label.new()

		lblTeachersModify.text = "Nombre d'enseignants : "
		lblPlacesModify.text = "Nombre de places : "

		lblTeachersModify.position = Vector2(10, 75)
		lblPlacesModify.position = Vector2(10, 145)

		window.add_child(lblTeachersModify)
		window.add_child(lblPlacesModify)

		# Ajout des champs de saisie
		var txtTeachers = LineEdit.new()
		var txtPlaces = LineEdit.new()

		txtTeachers.position = Vector2(200, 65)
		txtPlaces.position = Vector2(200, 135)
		txtTeachers.size = Vector2(200, 50)
		txtPlaces.size = Vector2(200, 50)

		window.add_child(txtTeachers)
		window.add_child(txtPlaces)

		# Ajout du bouton de validation
		var btnValidate1= Button.new()
		btnValidate1.icon = load("res://Images/Add.png")
		btnValidate1.size = Vector2(40,40)
		btnValidate1.position = Vector2(540,140)

		window.add_child(btnValidate1)

		btnValidate1.pressed.connect(func ():
			if txtTeachers.text != "" and txtPlaces.text != "" and _is_only_numbers(txtTeachers.text) and _is_only_numbers(txtPlaces.text):
				utils._update_formation(i, int(txtPlaces.text), int(txtTeachers.text))
				)
		
		# Quand btnModify est pressé, on affiche la window
		var lambda = func _on_texture_button_pressed():
			window.visible = true
		btnModify.connect("pressed", lambda)
		
		# Quand la window est fermée, on la cache
		var lambda2 = func _on_close_requested():
			window.visible = false
		window.connect("close_requested", lambda2)

		container.add_child(window)

		i += 1

func _is_only_numbers(input: String) -> bool:
	"""
	Description : Cette fonction est appelée pour vérifier si la chaine de caractères passée en paramètre contient uniquement des chiffres.

	Arguments :
		input : String : la chaine de caractères à vérifier.
	
	Retour :
		bool : True si la chaine de caractères contient uniquement des chiffres, False sinon.
	"""
	var regex = RegEx.new()
	regex.compile("^[0-9]+$")  # Motif : seulement des chiffres
	return regex.search(input) != null
