extends Button

@export var location_id: String
@export var location_name: String
@export var description: String
@export var location_image: Texture2D
@export var exterior_scene_path: String

@onready var name_label: Label = $NameBox/Label

signal location_selected(data: Dictionary)

func _ready() -> void:
	name_label.text = location_name
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	location_selected.emit({
		"id": location_id,
		"name": location_name,
		"description": description,
		"image": location_image,
		"scene": exterior_scene_path
	})
