extends Node
var menu = preload("res://scenes/menu.tscn")

var PAUSE = preload("res://scenes/pause.tscn")
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(0.44,0.12, 0.53, 1))
	
	#SettingsManager.load_settings()

func start_game():
	if get_tree().paused:
		resume_game()
		return
	SceneManager.tranisition_to("Level1")
	
func exit_game():
	get_tree().quit()

func pause_game():
	var pause = PAUSE.instantiate()
	get_tree().paused = true
	get_tree().get_root().add_child(pause)

func resume_game():
	
	get_tree().paused = false 
func main_menu():
	var menumain = menu.instantiate()
	get_tree().get_root().add_child(menumain)
