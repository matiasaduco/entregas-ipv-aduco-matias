extends Sprite2D
class_name Projectile

@export var speed: float = 300
var direction: Vector2
signal delete_requested(projectile)

func _ready() -> void:
	set_physics_process(false)

func set_starting_values(starting_position: Vector2, direction: Vector2):
	global_position = starting_position
	self.direction = direction
	$Timer.start()
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_timer_timeout() -> void:
	emit_signal("delete_requested", self)
