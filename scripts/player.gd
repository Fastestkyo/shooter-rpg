extends CharacterBody2D

var bullet = preload("res://scenes/bullet.tscn")
var player_deathfx = preload("res://scenes/player_death.tscn")
@onready var muzzle : Marker2D = $muzzle
@onready var anim = $AnimatedSprite2D
@onready var death: Timer = $death


func player_death():
	var player_deathinst = player_deathfx.instantiate() as Node2D
	player_deathinst.global_position = global_position
	get_parent().add_child(player_deathinst)
	
	Engine.time_scale = 0.5
	death.start()
	anim.visible = false
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		
		var tween = get_tree().create_tween()
		tween.tween_property(anim, "material:shader_parameter/enabled", true, 0)
		tween.tween_property(anim, "material:shader_parameter/enabled", false, 0.1)
		tween.tween_property(anim, "material:shader_parameter/enabled", true, 0)
		tween.tween_property(anim, "material:shader_parameter/enabled", false, 0.1)
		tween.tween_property(anim, "material:shader_parameter/enabled", true, 0)
		tween.tween_property(anim, "material:shader_parameter/enabled", false, 0.1)
		
		
		HealthManager.decrease_health(body.dmg_amt)
		
		
		
	if HealthManager.current_health  == 0:
		player_death()



	


func _on_death_timeout() -> void:
	HealthManager.current_health = 3
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Kill"):
		player_death()
