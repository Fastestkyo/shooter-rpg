extends NodeState

var bullet = preload("res://scenes/bullet.tscn")
@export var chara : CharacterBody2D
@export var anim : AnimatedSprite2D
@export var muzzle : Marker2D
@onready var audio: AudioStreamPlayer2D = $"../../sounds/AudioStreamPlayer2D2"
var muzzle_position : Vector2


func on_process(_delta : float):
	pass





func on_physics_process(_delta : float):
	
	gun_muzzle_position()
	
	if GameInputEvents.shoot_input():
		gun_shoot()
	
	# transitioning states
	
	# run state
	var direction : float = GameInputEvents.movement_input()
	
	if direction and chara.is_on_floor():
		transition.emit("Run")
	
	# jump state
	if GameInputEvents.jump_input():
		transition.emit("Jump")
	

func enter():
	muzzle.position = Vector2(17, -14)
	muzzle_position = muzzle.position
	
	anim.play("shoot_crouch")


func exit():
	anim.stop()




func gun_muzzle_position():
	if !anim.flip_h:
		muzzle.position.x = muzzle_position.x
	elif anim.flip_h:
		muzzle.position.x = -muzzle_position.x


func gun_shoot():
	var direction: float = -1 if anim.flip_h == true else 1
	var bullet_inst = bullet.instantiate() as Node2D
	bullet_inst.dir = direction
	bullet_inst.move_x_direction = true
	bullet_inst.global_position = muzzle.global_position
	anim.play("shoot_crounch")
	audio.playing = true
	get_parent().add_child(bullet_inst)
