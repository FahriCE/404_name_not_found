extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_texture_button_pressed() -> void:
	"""
	Description : Cette fonction est appelée lorsqu'on appuie sur le bouton de l'interface graphique afin de rendre visible la fenêtre de l'explorateur de fichiers.

	Arguments :
		None
	
	Retour :
		None
	"""
	$FormationChose.visible = !$FormationChose.visible

func _on_formation_chose_close_requested() -> void:
	"""
	Description : Cette fonction est appelée lorsqu'on appuie sur le bouton de fermeture de l'interface graphique afin de rendre invisible la fenêtre de l'explorateur de fichiers.

	Arguments :
		None
	
	Retour :
		None
	"""
	$FormationChose.hide()
