extends CharacterBody2D

var enemy_deathfx = preload("res://scenes/enemy_death.tscn")

@export var patrol_points : Node 
@export var speed: int = 1500
@export var wait_time: int = 3
@onready var timer: Timer = $Timer
@export var health_amt: int = 3
@export var dmg_amt: int = 1

@onready var anim = $AnimatedSprite2D

var grav = 1000

enum State { Idle, Walk } 
var dir :Vector2 = Vector2.LEFT
var current_state: State
var number_of_points: int
var point_positions: Array[Vector2]
var current_point : Vector2
var current_point_position: int
var can_walk : bool


func _ready() -> void:
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("no ctrl points")
	current_state = State.Idle
	timer.wait_time = wait_time
	
func _physics_process(delta: float) -> void:
	enemy_grav(delta)
	enemy_idle(delta)
	enemy_walk(delta)
	move_and_slide()
	enemy_anim()
func enemy_grav(delta: float):
	velocity.y += grav * delta


func enemy_idle(delta: float):
	if !can_walk:
		velocity.x = move_toward(velocity.x, 0 ,speed * delta)
		current_state = State.Idle
	
func enemy_walk(delta: float):
	if !can_walk:
		return
	if abs(position.x -current_point.x) > 0.5:
		velocity.x = dir.x * speed * delta
		current_state = State.Walk
	else:
		current_point_position += 1
		if current_point_position >= number_of_points:
			current_point_position = 0
		
		current_point = point_positions[current_point_position]
	
	
		if current_point.x > position.x:
			dir = Vector2.RIGHT
		else:
			dir = Vector2.LEFT
		
		can_walk = false
		timer.start()
	anim.flip_h = dir.x > 0

func enemy_anim():
	if current_state == State.Idle && !can_walk:
		anim.play("idle")
	elif current_state == State.Walk && can_walk:
		anim.play("walk")

func _on_timer_timeout() -> void:
	can_walk = true


func _on_hitbox_area_entered(area: Area2D) -> void:
	print("hitbox entered")
	if area.get_parent().has_method("get_dmg"):
		var node = area.get_parent() as Node
		health_amt -= node.dmg
		print(health_amt)
		
		if health_amt <= 0:
			var enemy_deathfx_instance = enemy_deathfx.instantiate() as Node2D
			enemy_deathfx_instance.global_position = global_position
			get_parent().add_child(enemy_deathfx_instance)
			queue_free()
