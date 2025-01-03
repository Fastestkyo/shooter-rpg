extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var player = get_parent().find_child("player")

var accel: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

@export var max_speed: float = 400.0  # Maximum speed for the bullet

func _physics_process(delta: float) -> void:
	# Calculate acceleration toward the player
	accel = (player.position - position).normalized() * 700
	
	# Update velocity
	velocity += accel * delta
	
	# Clamp velocity to the maximum speed
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	
	# Update rotation to match direction of movement
	rotation = velocity.angle()
	
	# Update position based on velocity
	position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	HealthManager.decrease_health(1)
	anim.play("explo")
	queue_free()

func _on_timer_timeout() -> void:
	anim.play("explo")
	queue_free()
