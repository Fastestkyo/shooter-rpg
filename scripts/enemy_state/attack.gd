extends NodeState
@export var character: CharacterBody2D
@export var animated: AnimatedSprite2D
@export var speed : int


var player: CharacterBody2D
var max_speed : int

func on_process(delta: float):
	pass

func on_physics_process(delta: float):
	var dir : int
	
	if character.global_position > player.global_position:
		animated.flip_h = false
		dir = -1
	elif character.global_position < player.global_position:
		animated.flip_h = true
		dir = 1
	animated.play("idle")
	
	character.velocity.x += dir * speed * delta
	character.velocity.x  = clamp(character.velocity.x, -max_speed ,max_speed)
	character.move_and_slide()
	
func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	max_speed = speed + 22
func exit():
	pass
