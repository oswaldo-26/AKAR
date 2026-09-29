extends CanvasLayer

@onready var popup_root: Control = $PopupRoot
@onready var location_image: TextureRect = $PopupRoot/PopupBox/MarginContainer/VBoxContainer/ContentRow/ImageFrame/LocationImg
@onready var name_label: Label = $PopupRoot/PopupBox/MarginContainer/VBoxContainer/ContentRow/TextColumn/LocationNameLabel
@onready var description_label: RichTextLabel = $PopupRoot/PopupBox/MarginContainer/VBoxContainer/ContentRow/TextColumn/DescriptionLabel
@onready var explore_button: Button = $PopupRoot/PopupBox/MarginContainer/VBoxContainer/ButtonRow/ExploreButton

var _pending_scene: String = ""

func _ready() -> void:
	popup_root.hide()
	explore_button.pressed.connect(_on_explore_pressed)
	close_button.pressed.connect(_on_close_pressed)

func _on_close_pressed() -> void:
	popup_root.hide()
func show_location(data: Dictionary) -> void:
	name_label.text = data["name"]
	description_label.text = data["description"]
	if data.get("image") != null:
		location_image.texture = data["image"]
	_pending_scene = data.get("scene", "")
	popup_root.show()

func _on_explore_pressed() -> void:
	if _pending_scene != "":
		get_tree().change_scene_to_file(_pending_scene)

@onready var close_button: Button = $PopupRoot/PopupBox/CloseButton
