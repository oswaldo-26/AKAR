extends Node2D

@export var scroll_speed: float = 20.0
@onready var clouds: Array[Sprite2D] = [$Cloud1, $Cloud4, $Cloud2, $Cloud3]

var cloud_width: float

func _ready() -> void:
	cloud_width = $Cloud1.texture.get_width() * $Cloud1.scale.x
	var screen_width: float = get_viewport_rect().size.x
	var spacing: float = screen_width / clouds.size()

	for i in clouds.size():
		clouds[i].position.x = i * spacing

func _process(delta: float) -> void:
	var screen_width: float = get_viewport_rect().size.x

	for cloud in clouds:
		cloud.position.x += scroll_speed * delta
		if cloud.position.x >= screen_width + cloud_width:
			cloud.position.x = -cloud_width   # always off-screen left, fixed
