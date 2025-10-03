extends AbstractEnemyState

func enter() -> void:
	character.velocity = Vector2.ZERO
	fire()


func fire() -> void:
	character._fire()
	character._play_animation("attack")

func exit() -> void:
	pass


func update(delta: float):
	character._look_at_target()


func handle_input(event: InputEvent) -> void:
	pass


func handle_event(event: StringName, value = null) -> void:
	pass


func _on_animation_finished(anim_name: StringName) -> void:
	if character.target == null:
		emit_signal("finished", "idle")
	else:
		match anim_name:
			"attack":
				character._play_animation("alert")
			"alert":
				if character._can_see_target():
					fire()
				else:
					emit_signal("finished", "idle")


func _handle_body_exited(body: Node) -> void:
	super._handle_body_exited(body)
	if character.target == null:
		if character.get_current_animation() != "attack":
			emit_signal("finished", "idle")
