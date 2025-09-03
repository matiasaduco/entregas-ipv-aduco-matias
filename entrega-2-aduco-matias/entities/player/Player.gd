extends Sprite2D

@export var speed: float = 500
@onready var cannon = $Cannon
@onready var screen_size: Vector2 = get_viewport_rect().size
var projectile_container: Node

func set_projectile_container(container: Node):
	cannon.projectile_container = container
	projectile_container = container

func _process(delta: float) -> void:
	var move_left = int(Input.is_action_pressed("move_left"))
	var move_right = int(Input.is_action_pressed("move_right"))
	var direction = move_right - move_left

	position.x += direction * speed * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	var mouse_position: Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire()
