extends Statee

var can_transition:=false

func enter():
	super.enter()
	anim.play("glowing")
	await dash()
	can_transition = true

func dash():
	var tween = create_tween()
	tween.tween_property(owner, "position", plr.position, 0.8)
	await tween.finished


func transition():
	if can_transition:
		can_transition = false
		
		get_parent().change_state("Follow")
