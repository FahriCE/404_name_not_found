extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	"""
	Description : Cette fonction est appelée à chaque frame pour vérifier si la fenêtre de l'explorateur de fichiers est visible ou non et changer l'image du bouton en conséquence.
	
	Arguments :
		delta : float : le temps écoulé depuis la dernière frame.

	Retour :
		None
	"""
	if $FileExplorerWindow.visible == true:
		$FileExplorerTextureButton.texture_normal = preload("res://Images/FolderCopen.png")
	else: 
		$FileExplorerTextureButton.texture_normal = preload("res://Images/FolderC.png")


func _on_texture_button_pressed():
	"""
	Description : Cette fonction est appelée lorsqu'on appuie sur le bouton de l'interface graphique afin de rendre visible la fenêtre de l'explorateur de fichiers.

	Arguments :
		None
	
	Retour :
		None
	"""
	$FileExplorerWindow.visible = true
