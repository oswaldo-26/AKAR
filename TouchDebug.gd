extends CanvasLayer

var label: Label

func _ready() -> void:
	layer = 200
	label = Label.new()
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.add_theme_font_size_override("font_size", 28)
	label.add_theme_color_override("font_color", Color.YELLOW)
	label.add_theme_color_override("font_outline_color", Color.BLACK)
	label.add_theme_constant_override("outline_size", 8)
	add_child(label)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		var h := get_viewport().gui_get_hovered_control()
		label.text = "TOUCH at %s\nhovering: %s" % [event.position, h.get_path() if h else "nothing"]
	elif event is InputEventMouseButton and event.pressed:
		var h2 := get_viewport().gui_get_hovered_control()
		label.text = "MOUSE at %s\nhovering: %s" % [event.position, h2.get_path() if h2 else "nothing"]
