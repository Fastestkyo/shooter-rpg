extends Sprite2D

var bullet_fx = preload("res://scenes/bullet_fx.tscn")

var speed : int = 600
var dir : int
var dmg : int = 1
var move_x_direction : bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if move_x_direction:
		move_local_x(dir * speed * delta)
	else:
		move_local_y(dir * speed * delta)

func _on_timer_timeout() -> void:
	queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	print("bullet area entered")
	bullet_impact()


func _on_hitbox_body_entered(body: Node2D) -> void:
	print("body entered")
	bullet_impact()
	
func get_dmg() -> int:
	return dmg

func bullet_impact():
	var bullet_impact_effect = bullet_fx.instantiate() as Node2D
	bullet_impact_effect.global_position = global_position
	get_parent().add_child(bullet_impact_effect)
	queue_free()
