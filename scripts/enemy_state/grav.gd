extends Node

@export var character : CharacterBody2D
@export var animated : AnimatedSprite2D

const grav = 1000

func _physics_process(delta: float) -> void:
	if !character.is_on_floor():
		character.velocity.y += grav * delta
	character.move_and_slide()
