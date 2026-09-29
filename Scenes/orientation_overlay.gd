extends CanvasLayer

@onready var rotate_popup: Control = $RotatePopup
@onready var close_button: Button = $RotatePopup/MarginContainer/CenterContainer/VBoxContainer/CloseButton

func _ready() -> void:
	get_viewport().size_changed.connect(_check_orientation)
	close_button.pressed.connect(_on_close_pressed)
	_check_orientation()

func _check_orientation() -> void:
	var size: Vector2 = get_viewport().get_visible_rect().size
	if size.x < size.y:
		rotate_popup.show()
	else:
		rotate_popup.hide()

func _on_close_pressed() -> void:
	rotate_popup.hide()
