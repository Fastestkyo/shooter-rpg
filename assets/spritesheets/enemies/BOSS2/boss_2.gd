extends CharacterBody2D

@onready var progress = $CanvasLayer/ProgressBar

@onready var plr = get_parent().find_child("player")
@onready var anim = $AnimatedSprite2D


var direction : Vector2
var health:= 25:
	set(value):
		health = value
		progress.value = value
		if value <= 0:
			progress.visible = false
			find_child("StateMachine").change_state("Death")

func _ready() -> void:
	set_physics_process(false)

func _process(delta: float) -> void:
	direction = plr.position - position
	
	if direction.x < 0:
		anim.flip_h = true
	else:
		anim.flip_h = false

func _physics_process(delta: float) -> void:
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)
	
func take_dmg(amt:int):
	health -= amt


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("asas")
	
	if area.get_parent().has_method("get_dmg"):
		print("arttts")
		var node = area.get_parent() as Node
		take_dmg(1)
