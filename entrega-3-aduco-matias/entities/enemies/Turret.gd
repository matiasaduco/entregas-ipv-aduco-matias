extends Sprite2D

@onready var fire_position: Node2D = $FirePosition
@onready var fire_timer: Timer = $FireTimer
@onready var raycast: RayCast2D = $RayCast2D

@export var projectile_scene: PackedScene

var target: Node2D
var projectile_container: Node
var is_firing: bool
var target_visible: bool

func _ready() -> void:
	fire_timer.connect("timeout", fire_at_player)


func _physics_process(delta: float) -> void:
	if target:
		var dir = (target.global_position - global_position)
		raycast.target_position = dir
		if raycast.is_colliding() && raycast.get_collider().name == "Player" && !is_firing:
			fire_timer.start()
			is_firing = true
		elif !raycast.is_colliding() || raycast.get_collider().name != "Player":
			fire_timer.stop()
			is_firing = false


func initialize(turret_pos: Vector2, projectile_container: Node) -> void:
	global_position = turret_pos
	self.projectile_container = projectile_container


func fire_at_player() -> void:
	var proj_instance = projectile_scene.instantiate()
	proj_instance.initialize(
		projectile_container,
		fire_position.global_position,
		fire_position.global_position.direction_to(target.global_position)
	)


func _on_detection_area_body_entered(body: Node2D) -> void:
	if target == null:
		target = body


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
		fire_timer.stop()
		is_firing = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
