extends NodeState
@export var char : CharacterBody2D 
@export var anim : AnimatedSprite2D

@export_category("physics")
@export var friction:int = 1700

func on_process(delta: float):
	pass

func on_physics_process(delta: float):
	char.velocity.x = move_toward(char.velocity.x,0,friction)
	char.move_and_slide()
	
	if !char.is_on_floor():
		transition.emit("Fall")
	
	var dir :float = GameInputEvents.movement_input()
	
	if dir and char.is_on_floor():
		transition.emit("Run")
	
	if GameInputEvents.jump_input():
		transition.emit("Jump")
		
	if GameInputEvents.shoot_input():
		transition.emit("ShootStand")
	
	if GameInputEvents.shoot_up_input():
		transition.emit("ShootUp")
		
	if GameInputEvents.crouch_input():
		transition.emit("ShootCrouch")
func enter():
	
	anim.play("idle")

func exit():
	anim.stop()
	
