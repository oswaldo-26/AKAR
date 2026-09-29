extends CanvasLayer

@onready var anim = $CanvasLayer/ColorRect/AnimationPlayer
@onready var color_rect = $CanvasLayer/ColorRect

func _ready():
	color_rect.modulate.a = 0
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func change_scene(path: String) -> void:
	anim.play("fade_out")
	await anim.animation_finished
	get_tree().change_scene_to_file(path)
	anim.play("fade_in")
