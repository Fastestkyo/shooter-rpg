extends Statee


func enter():
	super.enter()
	anim.play("melee_attack")
	HealthManager.decrease_health(0.5)

func transition():
	if owner.dir.length() > 30:
		get_parent().change_state("Follow")
		
