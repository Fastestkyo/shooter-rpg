extends Node2D

class_name Boss2_State

@onready var debuh = owner.find_child("debu")
@onready var anim = owner.find_child("AnimationPlayer")
@onready var plr = owner.get_parent().find_child("player")


func _ready() -> void:
	set_physics_process(false)

func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)

func transition():
	pass

func _physics_process(delta: float) -> void:
	transition()
	debuh.text = name
