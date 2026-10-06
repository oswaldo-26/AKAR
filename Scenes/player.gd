extends CharacterBody2D

@export var move_speed: float = 400.0

var last_direction: String = "down"

@onready var animated_sprite: AnimatedSprite2D = $Character

func _physics_process(delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Snap to one axis so it never moves diagonally
	if abs(input_vector.x) > abs(input_vector.y):
		input_vector = Vector2(sign(input_vector.x), 0)
	elif input_vector.y != 0:
		input_vector = Vector2(0, sign(input_vector.y))

	velocity = input_vector * move_speed
	move_and_slide()

	_update_animation(input_vector)

func _update_animation(input_vector: Vector2) -> void:
	if input_vector == Vector2.ZERO:
		animated_sprite.play("idle_" + last_direction)
		return

	if abs(input_vector.x) > abs(input_vector.y):
		last_direction = "right" if input_vector.x > 0 else "left"
	else:
		last_direction = "down" if input_vector.y > 0 else "up"

	animated_sprite.play("walk_" + last_direction)
