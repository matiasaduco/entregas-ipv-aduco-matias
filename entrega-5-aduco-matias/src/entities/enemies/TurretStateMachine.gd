extends GenericStateMachine

@export var character: Node

func _setup() -> void:
	if character == null:
		printerr("%s: character is not defined!" % name)
	for state: AbstractEnemyState in states_list:
		state.character = character


func _on_detection_area_body_entered(body: Node2D) -> void:
	current_state.handle_event("body_entered", body)


func _on_detection_area_body_exited(body: Node2D) -> void:
	current_state.handle_event("body_exited", body)


func _on_body_animation_finished() -> void:
	_on_animation_finished(character.get_current_animation())


func _on_turret_hit(amount: Variant) -> void:
	pass # Replace with function body.


func notify_hit(amount: Variant) -> void:
	if current_state != $Die:
		_change_state("dead")
