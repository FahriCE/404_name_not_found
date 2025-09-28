extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var titleLabel = $MarginContainer/VBoxContainer/TitleLabel as Label
@onready var screen = $TextureRect as TextureRect

@onready var menu = $MarginContainer as MarginContainer

var default_texture = preload("res://Images/Start_Interface_Off.png") as Texture
var transition_texture = preload("res://Images/Start_Interface_On.png") as Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	titleLabel.text = "404 NAME NOT FOUND"
	start_button.pressed.connect(on_start_pressed)
	exit_button.pressed.connect(on_exit_pressed)
	screen.texture = default_texture
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_start_pressed() -> void:
	# Changement de scène
	menu.visible = false
	screen.modulate = Color(1,1,1)

	# Attente de 2 sec
	await get_tree().create_timer(2.0).timeout
	
	screen.texture = transition_texture
	
	# Attente de 2 sec
	await get_tree().create_timer(2.0).timeout
	
	# Changement du scène Menu en jeu
	get_tree().change_scene_to_file("res://node_2d.tscn")

func on_exit_pressed() -> void:
	get_tree().quit()
