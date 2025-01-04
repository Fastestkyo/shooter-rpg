extends CharacterBody2D


@export var health_amt: int = 1
@export var dmg_amt : int = 1
const enemy_deathfx = preload("res://scenes/enemy_death.tscn")


	


	

func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("get_dmg"):
		var node = area.get_parent() as Node
		health_amt -= node.dmg
		
		if health_amt <= 0:
			var enemy_deathfx_instance = enemy_deathfx.instantiate() as Node2D
			enemy_deathfx_instance.global_position = global_position
			get_parent().add_child(enemy_deathfx_instance)
			queue_free()
