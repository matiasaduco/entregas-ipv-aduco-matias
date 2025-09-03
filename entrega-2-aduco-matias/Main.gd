extends Node

var spawn_distance_y = 350
@onready var turrets: Array[Sprite2D] = [$Turret_1, $Turret_2, $Turret_3]

func _ready() -> void:
	$Player.set_projectile_container(self)

	for turret in turrets:
		turret.set_values($Player, self)
		var random_x = randf_range(0, 1152)
		var random_y = $Player.position.y - randf_range(100, spawn_distance_y)
		turret.position = Vector2(random_x, random_y)
