extends Panel

@onready var transition_texture = $TransitionTexture as TextureRect
@onready var panel = $Panel as Panel
@onready var richTextLabel = $RichTextLabel as RichTextLabel
@onready var boss = $Boss as RichTextLabel
@onready var restart = $Restart as Button
@onready var main_screen = $MainScreen as Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition_texture.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_button_pressed() -> void:
	await get_tree().create_timer(0.5).timeout  # Attendre 1 seconde
	# get_tree().change_scene_to_file("res://main_menu.tscn")
	start_transition() # Avec les images de fin

func start_transition() -> void:

	transition_texture.z_index = 1  # Premier plan
	transition_texture.visible = true # Afficher le TextureRect

	transition_texture.texture = preload("res://Images/MenuDied2.png")
	await get_tree().create_timer(0.5).timeout  # Attendre 0.5 seconde

	transition_texture.texture = preload("res://Images/MenuDied3.png")
	await get_tree().create_timer(0.5).timeout  # Attendre 0.5 seconde

	transition_texture.texture = preload("res://Images/MenuDied4.png")
	await get_tree().create_timer(0.5).timeout  # Attendre 0.5 seconde

	transition_texture.texture = preload("res://Images/MenuDied5.png")
	await get_tree().create_timer(0.5).timeout  # Attendre 0.5 seconde

	transition_texture.texture = preload("res://Images/MenuDied6.png")
	await get_tree().create_timer(1.0).timeout  # Attendre 0.5 seconde

	get_tree().change_scene_to_file("res://main_menu.tscn")
