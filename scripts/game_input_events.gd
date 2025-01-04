class_name GameInputEvents
extends Node

static func movement_input() -> float:
	var dir :float = Input.get_axis("ui_left", "ui_right")
	return dir


static func jump_input() -> bool:
	var jump_inputa : bool = Input.is_action_just_pressed("ui_accept")
	return jump_inputa

static func shoot_input() -> bool:
	var shoot_inputa : bool = Input.is_action_just_pressed("shoot")
	return shoot_inputa
	
static func shoot_up_input() -> bool:
	var shoot_inputa : bool = Input.is_action_just_pressed("shoot")
	var up_inputa : bool = Input.is_action_pressed("face_up")
	return up_inputa and shoot_inputa

static func crouch_input() -> bool:
	var crouch_inputa : bool = Input.is_action_just_pressed("crouch")
	return crouch_inputa

static func fall_input() -> bool:
	var force_fall_inputa : bool = Input.is_action_just_pressed("force_fall")
	return force_fall_inputa

static func wall_cling() -> bool:
	var wall_clinga : bool = Input.is_action_just_pressed("wall_cling")
	return wall_clinga
