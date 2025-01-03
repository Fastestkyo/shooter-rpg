extends Statee

@export var bullet_node : PackedScene
var can_transition:=false

func enter():
	super.enter()
	anim.play("ranged_attack")
	await anim.animation_finished
	shoot()
	can_transition = true



func shoot():
	var bullet = bullet_node.instantiate()
	bullet.position = owner.position
	get_tree().current_scene.add_child(bullet)


func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Dash")
