extends Boss2_State

@onready var prog: ProgressBar = owner.find_child("ProgressBar")
@onready var col: CollisionShape2D = $"../../plr_detec/CollisionShape2D"


var player_entered:=false:
	set(value):
		player_entered = value
		col.set_deferred("disabled", value)
		prog.set_deferred("visible", value)


func _on_plr_detec_body_entered(body: Node2D) -> void:
	player_entered = true


func transition():
	if player_entered:
		get_parent().change_state("Follow")
