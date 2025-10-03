extends PlayerState

@export var jumps_limit: int = 1
var jumps: int = 0

func _ready() -> void:
	pass

func enter() -> void:
	character.velocity.y -= character.jump_speed
	character._play_animation("jump")

func exit() -> void:
	jumps = 0

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") && jumps < jumps_limit:
		jumps += 1
		character.velocity.y -= character.jump_speed
		character._play_animation("jump")

func update(delta: float) -> void:
	character._handle_weapon_actions()
	character._handle_move_input(delta)
	if character.h_movement_direction == 0:
		character._handle_deacceleration(delta)
	character._apply_movement(delta)
	if character.is_on_floor():
		if character.h_movement_direction == 0:
			emit_signal("finished", "idle")
		else:
			emit_signal("finished", "walk")
	else:
		if character.velocity.y > 0:
			character._play_animation("fall")
		else:
			character._play_animation("jump")

func _on_animation_finished(anim_name: StringName) -> void:
	pass

func handle_event(event: StringName, value = null) -> void:
	match event:
		&"hit":
			character._handle_hit(value)
			if character.dead:
				finished.emit(&"dead")
