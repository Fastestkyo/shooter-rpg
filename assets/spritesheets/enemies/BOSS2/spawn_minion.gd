extends Boss2_State
@export var minion : PackedScene
var can_transition := false

func enter():
	super.enter()
	anim.play("summon")
	await anim.animation_finished
	can_transition = true


func spawn():
	var minion_nde = minion.instantiate()
	minion_nde.position = owner.position + Vector2(40, -40)
	get_tree().current_scene.add_child(minion_nde)
func transition():
	if can_transition:
		get_parent().change_state("Follow")
