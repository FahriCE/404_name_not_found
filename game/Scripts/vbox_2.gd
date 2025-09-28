extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$ReponseSuperieur1.text = "Pour garantir un bon encadrement, 
le ratio optimal est généralement de 1 enseignant 
pour 20 à 30 étudiants dans les formations théoriques 
et de 1 pour 10 dans les formations pratiques."


func _on_button_2_pressed() -> void:
	$ReponseSuperieur1.text = "Les ressources humaines varient en fonction de la taille de
l'établissement. Un bon ratio serait 3 employé RH pour 100 
élèves, plus c'est mieux mais moins on prend des risques !"


func _on_button_3_pressed() -> void:
	$ReponseSuperieur1.text = "La satisfaction étudiante dépend souvent 
de la disponibilité du personnel et de l'organisation 
des cours. Un encadrement de qualité avec un ratio 
enseignant/étudiant équilibré augmente la satisfaction."
