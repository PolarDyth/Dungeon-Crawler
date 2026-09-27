extends State

func enter():
	actor.play_animation(Player.Anim.IDLE, actor.facing)
