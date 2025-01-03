extends CharacterBody2D

@onready var anim := $AnimatedSprite2D
@onready var plr = get_parent().find_child("player")


func _ready() -> void:
	set_physics_process(false)
	await anim.animation_finished
	set_physics_process(true)



func _physics_process(delta: float) -> void:
	var dir = plr.position - position
	velocity = dir.normalized() * 60
	move_and_slide()

func _on_timer_timeout() -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("hitbox entered")
	if area.get_parent().has_method("get_dmg"):
		var node = area.get_parent() as Node
		anim.play("kill")
		await anim.animation_finished
		queue_free()
