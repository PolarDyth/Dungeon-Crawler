extends CharacterBody2D
class_name Player

enum Facing {N, E, S, W}
enum Anim {IDLE, WALK, RUN}

# The only place raw animation names are spelled out.
const ANIMATIONS: Dictionary = {
	Anim.IDLE: {
		Facing.N: "idle_n",
		Facing.E: "idle_e",
		Facing.S: "idle_s",
		Facing.W: "idle_w",
	},
	Anim.WALK: {
		Facing.N: "walk_n",
		Facing.E: "walk_e",
		Facing.S: "walk_s",
		Facing.W: "walk_w",
	},
	Anim.RUN: {
		Facing.N: "run_n",
		Facing.E: "run_e",
		Facing.S: "run_s",
		Facing.W: "run_w",
	},
}

# Set a default starting direction
var facing: Facing = Facing.S
@export var equipped_weapon: Weapon

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var emitter = $ProjectileEmitter

func _ready():
	# Fail loudly at load if the library is missing anything the table promises.
	for category in ANIMATIONS:
		for dir in ANIMATIONS[category]:
			var anim_name = ANIMATIONS[category][dir]
			if not anim_player.has_animation(anim_name):
				push_error("Animation library is missing: ", anim_name)
	if equipped_weapon and not anim_player.has_animation(equipped_weapon.attack_name):
		push_error("Equipped weapon references missing animation: ", equipped_weapon.attack_name)

func play_animation(category: Anim, dir: Facing) -> void:
	var by_facing: Dictionary = ANIMATIONS.get(category, {})
	if by_facing.is_empty():
		push_error("No animation entries for category: ", Anim.keys()[category])
		return
	var anim_name = by_facing.get(dir)
	if anim_name == null:
		push_error("No animation for ", Anim.keys()[category], " facing ", Facing.keys()[dir])
		return
	anim_player.play(anim_name)

func fire_projectile():
	var aim_dir = global_position.direction_to(get_global_mouse_position())

	emitter.fire(equipped_weapon, aim_dir)
