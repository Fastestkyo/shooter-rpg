extends Boss2_State

var can_transition := false

func enter():
	super.enter()
	anim.play("skill")
	await anim.animation_finished
	can_transition = true

func teleport():
	owner.position = plr.position + (Vector2.RIGHT * 40) + (Vector2.UP * 100)


func transition():
	if can_transition:
		get_parent().change_state("Follow")
		can_transition = false
