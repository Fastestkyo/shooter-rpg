extends Node2D

@export var next_scene : String
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var key_id : String

var door_open: bool

func _on_exit_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var plr = body as CharacterBody2D
		plr.queue_free()
	await get_tree().create_timer(1.0).timeout
	print("trasnnistions")
	SceneManager.tranisition_to(next_scene)


func _on_activate_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var has_key : bool = InventoryManager.has_inv_item(key_id)
		if !has_key:
			return
		
		if !door_open:
			animated_sprite_2d.play("open")
			door_open = true
			collision_shape_2d.set_deferred("disabled", true)

func _on_activate_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if door_open:
			animated_sprite_2d.play("close")
			door_open = false
