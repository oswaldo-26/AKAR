extends Control

@onready var location_popup = $LocationPopup

func _ready() -> void:
	var markers = $MapContainer/Map.get_children()
	for marker in markers:
		if marker.has_signal("location_selected"):
			marker.location_selected.connect(_on_location_selected)

func _on_location_selected(data: Dictionary) -> void:
	location_popup.show_location(data)
