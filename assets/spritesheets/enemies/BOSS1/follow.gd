extends Statee

func enter():
	super.enter()
	owner.set_physics_process(true)
	anim.play("idle")

func exit():
	super.exit()
	owner.set_physics_process(false)


func transition():
	var dis = owner.dir.length()
	
	if dis < 30:
		get_parent().change_state("MeleeAttack")
	elif dis > 130:
		var chance = randi() % 2
		match chance:
			0:
				
				get_parent().change_state("HomingMissile")
			1:
				
				get_parent().change_state("LaserBeam")
