extends Camera2D

@export_category("Follow character")
@export var chara: CharacterBody2D

@export_category("Camera Smoothing")
@export var smoothing : bool
@export_range(1, 10) var smoothing_distance : int = 8
var weight : float

func _ready() -> void:
	weight = float(11 - smoothing_distance) / 100 

func _physics_process(_delta: float) -> void:
	
	if char != null:
		var char_position : Vector2
		
		if smoothing:
			
			char_position = lerp(global_position, chara.global_position, weight)
		else:
			char_position = chara.global_position
		
		global_position = char_position.floor()
