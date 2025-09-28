extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Fonction appelée lorsqu'on appuie sur le bouton 1 (informations sur les BUT)
func _on_button_pressed() -> void:
	$ReponseSuperieur1.text = "Les BUT (Bachelors Universitaires de Technologie) accueillent généralement 
							entre 120 et 190 étudiants par formation, répartis sur trois années.
							Ces formations allient théorie et pratique "
							

# Fonction appelée lorsqu'on appuie sur le bouton 2 (informations sur les Facultés)
func _on_button_2_pressed() -> void:
	$ReponseSuperieur1.text = "Les Fac proposent des formations variées,avec un nombre d'étudiants souvent élevé. 
							Les promotions vont de 300 à plusieurs milliers d'étudiants selon les filières.  
							Ces formations sont principalement théoriques et offrent 
							des options de spécialisation au fil des années."

# Fonction appelée lorsqu'on appuie sur le bouton 3 (informations sur les Prépas)
func _on_button_3_pressed() -> void:
	$ReponseSuperieur1.text = "Les classes préparatoires (Prépas) accueillent 
généralement entre 30 et 50 étudiants par classe. 
Ces formations intensives préparent aux concours 
des grandes écoles, avec un enseignement 
rigoureux et encadré par des professeurs experts."

# Fonction appelée lorsqu'on appuie sur le bouton 4 (informations sur les BTS)
func _on_button_4_pressed() -> void:
	$ReponseSuperieur1.text = "Les BTS (Brevet de Technicien Supérieur) forment 
des promotions de 30 à 40 étudiants en moyenne. 
Ces cursus en deux ans sont orientés vers 
l'acquisition de compétences professionnelles 
directement exploitables sur le marché de l'emploi."
