extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $FormationWindow.visible == true:
		$FileExplorerTextureButton.texture_normal = preload("res://Images/FolderCopen.png")
	else: 
		$FileExplorerTextureButton.texture_normal = preload("res://Images/FolderC.png")


func _on_file_explorer_texture_button_pressed():
	$FormationWindow.visible = true
