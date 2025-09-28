extends PanelContainer

@onready var buttonMailEx = $Button as Button
var has_notif = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mail_manager = $PageMail/PanelFondgris/ScrollContainer/VBoxContainer
	if mail_manager.has_signal("new_mail_generated"):
		mail_manager.connect("new_mail_generated", Callable(self, "_on_v_box_container_new_mail_generated"))
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $PageMail.visible and has_notif == true:
		$BoutonMail.texture_normal = preload("res://Images/MailNotifPressed.png")
	elif $PageMail.visible and has_notif == false:
		$BoutonMail.texture_normal = preload("res://Images/MailPressed.png")
	else:
		update_mail_notif()

func _on_bouton_mail_pressed() -> void:
	$PageMail.visible = !$PageMail.visible
	
	await get_tree().create_timer(2.0).timeout
	if $PageMail.visible and has_notif == true:
		has_notif = false
		update_mail_notif()

func _on_page_mail_close_requested() -> void:
	$PageMail.hide()
	
func update_mail_notif() -> void:
	if has_notif:
		$BoutonMail.texture_normal = preload("res://Images/MailNotif.png")
	else:
		$BoutonMail.texture_normal = preload("res://Images/Mail.png")

func _add_mail_incorrect_creation(file_json,mail) ->void:
	var mail_incorrect = {
		"id": 0,
		"sender": mail.sender,
		"content": "VOUS N'AVEZ PAS CREE LA BONNE FORMATION ATTENDU ["+mail.formation+"] JE SUIS PAS CONTENT",
		"date_sent": "2024-12-06 08:00:00",
		"formation": ""
	}
	file_json.append(mail_incorrect)
	$PageMail/PanelFondgris/ScrollContainer/VBoxContainer._add_all_mail(file_json)
	update_mail_notif()
	

func _on_v_box_container_new_mail_generated() -> void:
	has_notif = true
	update_mail_notif()
