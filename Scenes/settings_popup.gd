extends Control

@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var mute_check: CheckButton = %muteCheck
@onready var fullscreen_check: CheckButton = %fullscreenCheck
@onready var close_button: Button = %CloseButton

func _ready() -> void:
	hide()

	# add the dim behind everything
	var dim := ColorRect.new()
	dim.color = Color(0, 0, 0, 0.6)
	dim.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	dim.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(dim)
	move_child(dim, 0)

	music_slider.value_changed.connect(func(v): Settings.music_volume = v; Settings.apply_all())
	sfx_slider.value_changed.connect(func(v): Settings.sfx_volume = v; Settings.apply_all())
	mute_check.toggled.connect(func(on): Settings.muted = on; Settings.apply_all())
	fullscreen_check.toggled.connect(func(on): Settings.fullscreen = on; Settings.apply_all())
	close_button.pressed.connect(close)

func open() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	$PopupBox.custom_minimum_size = Vector2(560, 520)
	$PopupBox.size = Vector2(560, 520)
	$PopupBox.set_anchors_and_offsets_preset(Control.PRESET_CENTER)

	$PopupBox/MarginContainer.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	%CloseButton.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT)
	%CloseButton.position += Vector2(-48, 8)

	show()

func close() -> void:
	Settings.save_settings()
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		close()
