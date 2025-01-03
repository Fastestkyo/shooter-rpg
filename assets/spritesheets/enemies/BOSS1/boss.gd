extends CharacterBody2D

@onready var plr = get_parent().find_child("player")
@onready var sprite = $Sprite2D
@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar

var def = 0

var health = 35:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("StateMachine").change_state("Death")
		elif value <= progress_bar.max_value / 2 and def == 0:
			def = 2
			find_child("StateMachine").change_state("ArmorBuff")
		elif value <= progress_bar.max_value / 3 and def == 2:
			def = 3
			find_child("StateMachine").change_state("ArmorBuff")


var dir : Vector2

func _ready() -> void:
	set_physics_process(false)


func _process(delta: float) -> void:
	dir = plr.position - position
	
	if dir.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false


func _physics_process(delta: float) -> void:
	velocity = dir.normalized() * 40
	move_and_collide(velocity * delta)

func take_dmg(amt:int):
	health -= amt - def



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("get_dmg"):
		var node = area.get_parent() as Node
		take_dmg(4)
		
