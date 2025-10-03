extends AbstractEnemyState

@onready var idle_timer: Timer = $IdleTimer

func enter() -> void:
	character.velocity = Vector2.ZERO
	
	if character.target != null:
		character._play_animation("idle_alert")
	else:
		character._play_animation(&"idle")
	
	idle_timer.start()


func exit() -> void:
	idle_timer.stop()


func update(delta: float):
	character._apply_movement()
	
	if character._can_see_target():
		emit_signal("finished", "alert")


func handle_input(event: InputEvent) -> void:
	pass


func _handle_body_entered(body: Node) -> void:
	super._handle_body_entered(body)
	character._play_animation("alert")


func _handle_body_exited(body: Node) -> void:
	super._handle_body_exited(body)
	character._play_animation("go_normal")


func _on_animation_finished(anim_name: StringName) -> void:
	return


func _on_idle_timer_timeout() -> void:
	emit_signal("finished", "walk")
