extends Marker2D
class_name ProjectileEmitter

func fire (weapon: Weapon, direction: Vector2):
	if not weapon or not weapon.is_ranged or not weapon.projectile_scene:
		return
	
	var projectile = weapon.projectile_scene.instantiate()
	
	projectile.setup(direction.normalized(), weapon.projectile_speed, weapon.damage)
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = self.global_position

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("The scene is now outside the viewport!")
