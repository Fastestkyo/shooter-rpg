extends Node2D

@export var pickup_amt :int = 1

func _on_health_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		HealthManager.increase_health(pickup_amt)
		queue_free()
