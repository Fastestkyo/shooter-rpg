extends Node
var LOADING_SCREEN = preload("res://scenes/loading_screen.tscn")
var scenes : Dictionary = {"Level1": "res://scenes/level1.tscn", "Level2": "res://scenes/level_2.tscn", "Level3": "res://scenes/level_3.tscn", "test": "res://scenes/test.tcsn",
"boss": "res://scenes/boss_room1.tscn"
}

func tranisition_to(level:String):
	var scene_path : String = scenes.get(level)
	
	if scene_path != null:
		var scene_transition = LOADING_SCREEN.instantiate()
		get_tree().get_root().add_child(scene_transition)
		
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file(scene_path)
		scene_transition.queue_free()
