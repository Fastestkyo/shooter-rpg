extends CanvasLayer


func _on_continue_pressed() -> void:
	game_update.resume_game()
	queue_free()
	

func _on_exit_pressed() -> void:
	game_update.main_menu()
	queue_free()
