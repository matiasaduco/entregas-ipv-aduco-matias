extends AbstractEnemyState

@export var wander_radius: Vector2 = Vector2(10.0, 10.0)
@export var speed: float = 10.0
@export var max_speed: float = 100.0
@export var pathfinding_step_threshold: float = 5.0

var path: Array

func enter() -> void:
	if character.pathfinding != null:
		var random_point: Vector2 = (
			character.global_position +
			Vector2(
				randf_range(-wander_radius.x, wander_radius.x),
				randf_range(-wander_radius.y, wander_radius.y)
			)
		)
		path = character.pathfinding.get_simple_path(
			character.global_position,
			random_point
		)
		if path.is_empty() || path.size() == 1:
			emit_signal("finished", "idle")
		else:
			if character.target != null:
				character._play_animation("walk_alert")
			else:
				character._play_animation("walk")
	else:
		emit_signal("finished", "idle")


func exit() -> void:
	path = []


func handle_input(event: InputEvent) -> void:
	pass

func handle_event(event: StringName, value = null) -> void:
	pass


func update(delta: float):
	if character._can_see_target():
		emit_signal("finished", "alert")
		return
	
	if path.is_empty():
		emit_signal("finished", "idle")
		return

	var next_point: Vector2 = path.front()
	
	while character.global_position.distance_to(next_point) < pathfinding_step_threshold:
		path.pop_front()
		
		if path.is_empty():
			emit_signal("finished", "idle")
			return
		
		next_point = path.front()
	
	character.velocity = (
		character.velocity +
		character.global_position.direction_to(next_point) * speed
	).limit_length(max_speed)
	character._apply_movement(delta)
	character.body_anim.flip_h = character.velocity.x < 0

func _on_animation_finished(anim_name: StringName) -> void:
	return
