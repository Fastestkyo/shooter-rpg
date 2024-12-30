extends NodeState

@export var chara : CharacterBody2D 
@export var anim : AnimatedSprite2D
@export var coyote_time:float = 0.1

const GRAVITY :int = 1700
var coyote_jump:bool

func on_process(delta: float):
	pass

func on_physics_process(delta: float):
	if !chara.is_on_floor():
		get_coyote_time()
		chara.velocity.y += GRAVITY * delta
	chara.move_and_slide()
	
	
	
	if chara.is_on_floor():
		transition.emit("Idle")
	
	if GameInputEvents.jump_input() and coyote_jump == true:
		transition.emit("Jump")
	
func enter():
	coyote_jump = true
	anim.play("fall")

func exit():
	anim.stop()
func get_coyote_time():
	await get_tree().create_timer(coyote_time).timeout
	coyote_jump =false
