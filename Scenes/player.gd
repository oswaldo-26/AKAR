extends CharacterBody2D

@export var move_speed: float = 200.0

var last_direction: String = "down"

@onready var animated_sprite: AnimatedSprite2D = $Character

func _physics_process(delta: float) -> void:
	var input_vector: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	input_vector = input_vector.normalized()

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
