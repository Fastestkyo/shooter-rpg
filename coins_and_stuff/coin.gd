extends Node2D

@export var coin_amt : int = 1
@onready var anim = $AnimatedSprite2D
@onready var lbl = $Label

func _ready() -> void:
	lbl.hide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("1+ coin")
		
		anim.hide()
		
		lbl.text = "%s" % coin_amt
		CollectibleManager.award_on_pick(coin_amt)
		
		lbl.show()
		
		var tween = get_tree().create_tween()
		tween.tween_property(lbl, "position", Vector2(lbl.position.x, lbl.position.y + -10), 0.5).from_current()
		tween.tween_callback(queue_free)
