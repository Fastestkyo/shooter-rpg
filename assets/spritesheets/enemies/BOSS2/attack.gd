extends Boss2_State

func enter():
	super.enter()
	combo()

func attack(move = "1"):
	anim.play("attack_" + move)
	await anim.animation_finished


func combo():
	var move_Set = ["1", "1", "2"]
	for i in move_Set:
		await  attack(i)
		
	combo()
	

func transition():
	if owner.direction.length() > 40:
		get_parent().change_state("Follow")

func dmg():
	HealthManager.decrease_health(1)
