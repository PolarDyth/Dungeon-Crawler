extends State
class_name Move
@export var speed: float

@export_category("Animation_Type")
@export var move_anim: Player.Anim

func physics_update(_delta: float):
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Apply facing direction
	if input_dir.x > 0:
		actor.facing = Player.Facing.E
	elif input_dir.x < 0:
		actor.facing = Player.Facing.W
	elif input_dir.y > 0:
		actor.facing = Player.Facing.S
	elif input_dir.y < 0:
		actor.facing = Player.Facing.N

	actor.play_animation(move_anim, actor.facing)
	actor.velocity = input_dir * speed
	actor.move_and_slide()
