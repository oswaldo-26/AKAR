extends CanvasLayer

@onready var rotate_popup: Control = $RotatePopup
@onready var close_button: Button = $RotatePopup/MarginContainer/CenterContainer/VBoxContainer/CloseButton

var dismissed := false

func _ready() -> void:
	get_tree().root.size_changed.connect(_check_orientation)
	close_button.pressed.connect(_on_close_pressed)

	# Browsers don't always fire size_changed on rotation, so re-check twice a second
	var t := Timer.new()
	t.wait_time = 0.5
	t.timeout.connect(_check_orientation)
	add_child(t)
	t.start()

	_check_orientation()

func _is_portrait() -> bool:
	if OS.has_feature("web"):
		return bool(JavaScriptBridge.eval("window.innerHeight > window.innerWidth"))
	var win := DisplayServer.window_get_size()
	return win.y > win.x

func _check_orientation() -> void:
	var portrait := _is_portrait()
	if not portrait:
		dismissed = false
	rotate_popup.visible = portrait and not dismissed

func _on_close_pressed() -> void:
	dismissed = true
	rotate_popup.hide()
