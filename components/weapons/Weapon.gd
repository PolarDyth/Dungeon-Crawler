extends Resource
class_name Weapon

@export var attack_name: String = "laser_bolt"
@export var damage: int = 10
@export var attack_duration: float = 0.1
@export var combo_capable: bool = false

@export_group("Ranged Properties")
@export var is_ranged: bool = false
@export var projectile_scene: PackedScene
@export var projectile_speed: float = 400.0

func apply_damage(target):
	#target.take_damage(damage)
	pass
