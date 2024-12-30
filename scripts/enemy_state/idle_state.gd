extends NodeState

@export var character : CharacterBody2D
@export var animated : AnimatedSprite2D
@export var slow_down:int = 50
func on_process(delta: float):
	pass

func on_physics_process(delta: float):
	character.velocity.x = move_toward(character.velocity.x, 0, slow_down * delta)
	animated.play("idle")
	character.move_and_slide()
	
func enter():
	pass

func exit():
	pass
