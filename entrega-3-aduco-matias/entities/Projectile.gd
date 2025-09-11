extends Sprite2D

@onready var lifetime_timer = $LifetimeTimer

@export var VELOCITY: float = 800.0

var direction:Vector2

func initialize(container, spawn_position:Vector2, spawn_direction:Vector2):
	container.add_child(self)
	self.direction = spawn_direction
	global_position = spawn_position
	lifetime_timer.connect("timeout", Callable(self, "_on_lifetime_timer_timeout"))
	lifetime_timer.start()

func _physics_process(delta):
	position += direction * VELOCITY * delta
	
	# Necesitamos que desaparezca en algun momento
	
	# Si está fuera de la pantalla
	var visible_rect:Rect2 = get_viewport().get_visible_rect()
	if !visible_rect.has_point(global_position):
		_remove()

# Si supero una cantidad de tiempo de vida
func _on_lifetime_timer_timeout():
	_remove()

func _remove():
	get_parent().remove_child(self)
	queue_free()


func _on_enemy_entered(body: Node2D) -> void:
	if body.name != "Player":
		self.queue_free()


func _on_player_entered(body: Node2D) -> void:
	if body.name != "Turret":
		self.queue_free()
