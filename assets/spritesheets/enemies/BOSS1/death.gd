extends Statee


func enter():
	super.enter()
	anim.play("death")
	await anim.animation_finished
	anim.play("boss_defeated")
