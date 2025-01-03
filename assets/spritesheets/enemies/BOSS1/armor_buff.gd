extends Statee

var can_transition := false

func enter():
	super.enter()
	anim.play("armor_buff")
	await anim.animation_finished
	can_transition = true


func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Follow")
