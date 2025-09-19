extends Node2D

@onready var weapon_tip: Node2D = $WeaponTip

@export var projectile_scene: PackedScene

var projectile_container: Node


## Desacoplamos el manejo del arma para que maneje su propia lógica.
## Es útil si queremos controlar su implementación independientemente
## o si queremos introducir variedad (muchas armas, por ejemplo).
func process_input() -> void:
	look_at(get_global_mouse_position())


func fire() -> void:
	var projectile_instance: Node = projectile_scene.instantiate()
	projectile_container.add_child(projectile_instance)
	projectile_instance.initialize(
		weapon_tip.global_position,
		global_position.direction_to(weapon_tip.global_position)
	)
