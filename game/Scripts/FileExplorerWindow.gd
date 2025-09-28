extends Window

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	"""
	Description : Cette fonction est appelée à chaque fois qu'un événement est détecté pour vérifier si la touche échappe est appuyée et cacher la fenêtre en conséquence.

	Arguments :
		event : InputEvent : l'événement détecté.
	
	Retour :
		None
	"""
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_ESCAPE:
				hide()

func _on_close_requested():
	hide()
