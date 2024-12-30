extends CanvasLayer

@onready var collectible_lbl = $MarginContainer/VBoxContainer/HBoxContainer/Label

func _ready() -> void:
	CollectibleManager.on_collectible_award_received.connect(on_collectable_award_received)
	
func on_collectable_award_received(total_award: int):
	collectible_lbl.text = str(total_award)


func _on_paubutton_pressed() -> void:
	game_update.pause_game()
