extends CanvasLayer

@onready var window_mode_button: OptionButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/window_mode
@onready var resolution_button: OptionButton = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/resolution

var window_modes :Dictionary = {"Fullscreen":DisplayServer.WINDOW_MODE_FULLSCREEN,
								"Window":DisplayServer.WINDOW_MODE_WINDOWED,
								"Window Maximized":DisplayServer.WINDOW_MODE_MAXIMIZED
								} 
var resolutions: Dictionary = {"320x180": Vector2i(320, 180),
								"400x270": Vector2i(480, 720),
								"640x360": Vector2i(640, 360),
								"854x480": Vector2i(864, 480),
								"1280x720": Vector2i(1280, 720),
								}

func _ready() -> void:	
	for window_mode in window_modes:
		window_mode_button.add_item(window_mode)
	
	for resolution in resolutions:
		resolution_button.add_item(resolution)
	init_controls()

func init_controls():
	SettingsManager.load_settings()
	var settings_data : SettingsDataResource = SettingsManager.get_settings()
	window_mode_button.selected = settings_data.window_mode_index
	resolution_button.selected = settings_data.resolution_index

func _on_window_mode_item_selected(index: int) -> void:
	var window_mode = window_modes.get(window_mode_button.get_item_text(index)) as int
	SettingsManager.set_window_mode(window_mode, index)


func _on_resolution_item_selected(index: int) -> void:
	var resolution = resolutions.get(resolution_button.get_item_text(index)) as Vector2i
	SettingsManager.set_resolution(resolution, index)


func _on_exit_pressed() -> void:
	SettingsManager.save_settings()
	queue_free()
