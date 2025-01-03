extends CharacterBody2D

var bullet = preload("res://scenes/bullet.tscn")
var player_deathfx = preload("res://scenes/player_death.tscn")
@onready var muzzle: Marker2D = $muzzle
@onready var anim = $AnimatedSprite2D
@export var death: Timer 

func _ready() -> void:
	anim.visible = true
	HealthManager.current_health = 3

func player_death():
	var player_deathinst = player_deathfx.instantiate() as Node2D
	player_deathinst.global_position = global_position
	get_parent().add_child(player_deathinst)
	anim.play("death")
	anim.visible = false
	get_tree().reload_current_scene()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		var tween = get_tree().create_tween()
		for i in range(3):
			tween.tween_property(anim, "material:shader_parameter/enabled", true, 0)
			tween.tween_property(anim, "material:shader_parameter/enabled", false, 0.1)
		HealthManager.decrease_health(body.dmg_amt)

func _physics_process(delta: float) -> void:
	if HealthManager.current_health <= 0:
		player_death()

func _on_death_timeout() -> void:
	get_tree().reload_current_scene()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Kill"):
		player_death()
