extends Statee

@onready var pivot = $"../../pivot"
var can_transition := false
func enter():
	super.enter()
	await play_anim("laser_cast")
	await play_anim("laser")
	HealthManager.decrease_health(1)
	can_transition = true
	
func play_anim(anim_name):
	anim.play(anim_name)
	await anim.animation_finished



func set_target():
	pivot.rotation = (owner.dir - pivot.position).angle()

func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")
