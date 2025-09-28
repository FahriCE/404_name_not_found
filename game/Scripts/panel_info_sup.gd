extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	"""
	Description : Affiche la fenêtre d'information supplémentaire

	Arugments : 
		None
	
	Retour :
		None
	"""
	$VBoxContainer/TextureButton/WindowInfoSupDetailler.visible = true

func _on_window_info_sup_detailler_close_requested() -> void:
	"""
	Description : Cache la fenêtre d'information supplémentaire

	Arugments : 
		None
	
	Retour :
		None
	"""
	$VBoxContainer/TextureButton/WindowInfoSupDetailler.hide()

func _on_texture_button_2_pressed() -> void:
	"""
	Description : Affiche la fenêtre d'information supplémentaire

	Arugments : 
		None
	
	Retour :
		None
	"""
	$VBoxContainer/TextureButton2/WindowInfoSupDetailler2.visible = true


func _on_window_info_sup_detailler_2_close_requested() -> void:
	"""
	Description : Cache la fenêtre d'information supplémentaire

	Arugments : 
		None
	
	Retour :
		None
	"""
	$VBoxContainer/TextureButton2/WindowInfoSupDetailler2.hide()


func _on_texture_button_3_pressed() -> void:
	"""
	Description : Affiche la fenêtre d'information supplémentaire

	Arugments : 
		None
	
	Retour :
		None
	"""
	$VBoxContainer/TextureButton3/WindowInfoSupDetailler3.visible = true

func _on_window_info_sup_detailler_3_close_requested() -> void:
	"""
	Description : Cache la fenêtre d'information supplémentaire

	Arugments : 
		None
	
	Retour :
		None
	"""
	$VBoxContainer/TextureButton3/WindowInfoSupDetailler3.hide()


func _on_window_info_sup_close_requested():
	"""
	Description : Cache toutes les fenêtres d'information supplémentaire

	Arugments : 
		None
	
	Retour :
		None
	"""
	get_parent().hide()
