extends CanvasLayer

var SETTINGS = preload("res://scenes/settings.tscn")


func _on_play_pressed() -> void:
	game_update.start_game()


func _on_exit_pressed() -> void:
	game_update.exit_game()


func _on_settings_pressed() -> void:
	var settings_menu = SETTINGS.instantiate()
	get_tree().get_root().add_child(settings_menu)
