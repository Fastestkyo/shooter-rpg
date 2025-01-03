extends Boss2_State


func enter():
	super.enter()
	anim.play("death")

func boss_ded():
	anim.play("boss_slained")
