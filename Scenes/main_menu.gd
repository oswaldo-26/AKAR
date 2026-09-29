extends Control

func _ready():
	$VBoxContainer/StartBtn.pressed.connect(_on_start_btn_pressed)
	$VBoxContainer/SettingsBtn.pressed.connect(_on_settings_btn_pressed)
	$VBoxContainer/AboutBtn.pressed.connect(_on_about_btn_pressed)

func _on_start_btn_pressed() -> void:
	Transition.change_scene("res://Scenes/LocationSelection.tscn")
	print("Start Pressed")
	pass # Replace with function body.


func _on_settings_btn_pressed() -> void:
	$SettingsPopup.open()


func _on_about_btn_pressed() -> void:
	print("About Pressed")
	pass # Replace with function body.
