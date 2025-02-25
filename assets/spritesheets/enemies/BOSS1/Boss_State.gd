extends Node2D
class_name Statee

@onready var debug = owner.find_child("debug")
@onready var plr = owner.get_parent().find_child("player")
@onready var anim = owner.find_child("AnimationPlayer")


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
	debug.text = name
