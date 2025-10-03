extends AbstractEnemyState

func enter() -> void:
	character._play_animation("dead")
	character.dead = true
	character.collision_layer = 0
	character.collision_mask = 0
	
	if character.target != null:
		character._play_animation("die_alert")
	else:
		character._play_animation("die")


func exit() -> void:
	pass


func handle_input(event: InputEvent) -> void:
	pass


func handle_event(event: StringName, value = null) -> void:
	pass


func update(delta: float):
	pass


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name in ["die_alert", "die"]:
		character._remove()
