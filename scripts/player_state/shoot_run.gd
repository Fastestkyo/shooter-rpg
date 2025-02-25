extends NodeState

var bullet = preload("res://scenes/bullet.tscn")
@export var chara : CharacterBody2D
@export var anim : AnimatedSprite2D
@export var muzzle : Marker2D
@onready var audio: AudioStreamPlayer2D = $"../../sounds/AudioStreamPlayer2D2"
@export_category("run")
@export var speed : int = 1000
@export var max_hori : int = 300

var muzzle_position : Vector2


func on_process(_delta : float):
	pass


func on_hold_gun_timout():
	transition.emit("Idle")



func on_physics_process(_delta : float):
	var dir = GameInputEvents.movement_input()
	gun_muzzle_position(dir)
	
	if GameInputEvents.shoot_input():
		gun_shoot(dir)
	
	if dir:
		chara.velocity.x += dir*speed
		chara.velocity.x = clamp(chara.velocity.x, -max_hori, max_hori)
	if dir != 0:
		anim.flip_h = false if dir > 0 else true
	chara.move_and_slide()
	
	
	if !chara.is_on_floor():
		transition.emit("Fall")
	if dir == 0:
		transition.emit("Idle")
	if GameInputEvents.jump_input():
		transition.emit("Jump")

func enter():
	muzzle.position = Vector2(17, -26)
	muzzle_position = muzzle.position 
	anim.play("shoot_run")
	

func exit():
	anim.stop()




func gun_muzzle_position(dir : float):
	if dir > 0:
		muzzle.position.x = muzzle_position.x
	elif dir < 0:
		muzzle.position.x = -muzzle_position.x


func gun_shoot(dir : float):

	var bullet_inst = bullet.instantiate() as Node2D
	bullet_inst.dir = dir
	bullet_inst.move_x_direction = true
	bullet_inst.global_position = muzzle.global_position
	anim.play("shoot_run")
	audio.playing = true
	get_parent().add_child(bullet_inst)
