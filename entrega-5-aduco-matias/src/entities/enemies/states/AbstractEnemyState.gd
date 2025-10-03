@abstract
class_name AbstractEnemyState extends AbstractState

var character: CharacterBody2D

func handle_event(event: StringName, value = null) -> void:
	match event:
		"body_entered":
			_handle_body_entered(value)
		"body_exited":
			_handle_body_exited(value)


func _handle_body_entered(body: Node) -> void:
	if character.target == null:
		character.target = body


func _handle_body_exited(body: Node) -> void:
	if body == character.target:
		character.target = null
