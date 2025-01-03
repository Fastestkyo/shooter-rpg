extends NodeState

@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@onready var jump: Timer = $"../../jump"

@export_category("Jump State")
@export var jump_height :  float = -250
@export var jump_horizontal_speed : int = 500
@export var max_jump_horizontal_speed : int = 300
@export var max_jump_count : int = 1
@export var jump_gravity : int = 1000
@onready var jump_cd: Timer = $"../../jump"
@onready var audio: AudioStreamPlayer2D = $"../../sounds/AudioStreamPlayer2D"

var current_jump_count : int
var coyote_jump : bool
var cooldown_coyote : bool = true

func on_process(delta : float):
	pass


func on_physics_process(delta : float):
	
	character_body_2d.velocity.y += jump_gravity * delta
	
	if character_body_2d.is_on_floor():
		current_jump_count = 0
		character_body_2d.velocity.y = jump_height
		coyote_jump = false
		current_jump_count += 1
		audio.playing = true
		
	if coyote_jump and cooldown_coyote == true:
		current_jump_count = 0
		character_body_2d.velocity.y = jump_height
		coyote_jump = false
		cooldown_coyote = false
		current_jump_count += 1
		audio.playing = true
		jump_cd.start()
	
	# multiple jumps
	if !character_body_2d.is_on_floor() and GameInputEvents.jump_input() and current_jump_count != max_jump_count:
		character_body_2d.velocity.y = jump_height
		current_jump_count += 1
		audio.playing = true
	
	var direction : float = GameInputEvents.movement_input()
	
	if !character_body_2d.is_on_floor():
		character_body_2d.velocity.x += direction * jump_horizontal_speed
		character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_jump_horizontal_speed, max_jump_horizontal_speed)
		
	character_body_2d.move_and_slide()
	
	# transitioning states
	
	# idle state
	if character_body_2d.is_on_floor():
		transition.emit("Idle")
	
	# wall cling state
	if GameInputEvents.wall_cling() and character_body_2d.is_on_wall() and cooldown_coyote == true:
		transition.emit("ShootWallCling")

func enter():
	coyote_jump = true
	animated_sprite_2d.play("jump")


func exit():
	coyote_jump = false
	animated_sprite_2d.stop()


func _on_jump_timeout() -> void:
	cooldown_coyote = true
