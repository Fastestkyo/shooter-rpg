extends Statee

@onready var col: CollisionShape2D = $"../../CollisionShape2D"

@onready var progress_bar = owner.find_child("ProgressBar")

var plyr_entered: bool = false:
	set(value):
		plyr_entered = value
		col.set_deferred("disabled", value)
		progress_bar.set_deferred("visible", value)

func transition():
	if plyr_entered:
		get_parent().change_state("Follow")

func _on_area_2d_body_entered(body: Node2D) -> void:
	plyr_entered = true
