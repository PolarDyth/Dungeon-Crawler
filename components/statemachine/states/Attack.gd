extends State

func _init():
	is_interrupt = true

func enter():
	actor.velocity = Vector2.ZERO

	var current_weapon = actor.equipped_weapon

	if current_weapon:
		var anim_player = actor.get_node("AnimationPlayer")
		anim_player.play(current_weapon.attack_name)

		await anim_player.animation_finished

		finished.emit()
	else:
		finished.emit()

func physics_update(_delta: float):
	actor.move_and_slide()
