extends NodeState

@export var chara: CharacterBody2D 
@export var anim: AnimatedSprite2D 

@export_category("Run State")
@export var speed:int = 1000
@export var max_hori:int = 300

func on_process(delta: float):
	pass

func on_physics_process(delta: float):
	var dir: float = GameInputEvents.movement_input()
	if dir:
		chara.velocity.x += dir * speed
		chara.velocity.x = clamp(chara.velocity.x, -max_hori, max_hori)
	if dir != 0:
		anim.flip_h = false if dir > 0 else true
	
	if dir != 0 and GameInputEvents.shoot_input():
		transition.emit("ShootRun")
		
	chara.move_and_slide()
	
	if dir == 0:
		transition.emit("Idle")
	if GameInputEvents.jump_input():
		transition.emit("Jump")
		
	if !chara.is_on_floor():
		transition.emit("Fall")
func enter():
	anim.play("run")

func exit():
	anim.stop()
