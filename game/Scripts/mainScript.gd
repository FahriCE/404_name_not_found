extends Node2D

const GAME_OVER_SCENE = "res://game_over.tscn"

@onready var screen = $TextureRect as TextureRect
@onready var tauxReussite = $barTauxReussite as ProgressBar

var game_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	"""
	Description : Cette fonction est appelée lors de la première entrée du noeud dans l'arbre de scène afin de regénérer le json des formations existantes.

	Arguments :
		None
	
	Retour :
		None
	"""
	formationsSeeder()
	await get_tree().create_timer(2.0).timeout
	$"PanelMail/PageMail/PanelFondgris/ScrollContainer/VBoxContainer"._mail_existant_reset()

func _first_turn():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_started and tauxReussite.value <= 30:
		var game_over_instance = preload(GAME_OVER_SCENE).instantiate()
		add_child(game_over_instance)

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ESCAPE:
				$EscapeMenu.visible = !$EscapeMenu.visible


# Leave Game button of MenuEchap function
func _on_button_pressed(): 
	get_tree().quit()

func formationsSeeder():
	"""
	Description : Cette fonction est appelée pour générer le fichier JSON des formations existantes.

	Arguments :
		None
	
	Retour :
		None
	"""
	var formationsExistantesSeeder = [
		{
			"id": 0,
			"formation": "Informatique",
			"croissance": "Positive",
			"popularite": "Extrêmement populaire",
			"specialities": {
				"titre": "Développement mobile",
				"nbPlaces": int(90),
				"nbEnseignants": int(7),
				"nbEtudiants" : int(86),
				"tauxReussite": int(81)
			}
		},
		{
			"id": 1,
			"formation": "Médecine",
			"croissance": "Positive",
			"popularite": "Extrêmement populaire",
			"specialities": {
				"titre": "Chirurgie",
				"nbPlaces": int(90),
				"nbEtudiants" : int(90),
				"nbEnseignants": int(4),
				"tauxReussite": int(53)
			}
		},
		{
			"id": 2,
			"formation": "Automobile",
			"croissance": "Positive",
			"popularite": "Extrêmement populaire",
			"specialities": {
				"titre": "Méchanique automobile",
				"nbPlaces": int(90),
				"nbEnseignants": int(2),
				"nbEtudiants" : int(72),
				"tauxReussite": int(37)
			}
		}
	]
	
	var path = "user://Data/FormationExistante.json"

	var file = FileAccess.open(path, FileAccess.WRITE)

	file.store_string(JSON.stringify(formationsExistantesSeeder))

func _on_button_info_pressed() -> void:
	$WindowInfoSup.visible = true


func _on_button_escape_pressed():
	$EscapeMenu.visible = true


func _on_texture_button_pressed() -> void:
	game_started = true


func _on_button_2_pressed() -> void:
	var path = "user://Data/FormationExistante.json"
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	var formations = JSON.parse_string(content)

	$Label2.text = formations[0]["formation"]
