extends Area2D

var direction: Vector2 = Vector2.ZERO
var speed: float = 0.0
var damage: int = 0

func setup(dir: Vector2, spd: float, dmg: int):
	direction = dir
	speed = spd
	damage = dmg

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
