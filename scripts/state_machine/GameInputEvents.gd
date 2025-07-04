class_name GameInputEvents
extends Node

static func movement_input() -> Vector2:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("walk_up"):
		direction.y -= 1
	if Input.is_action_pressed("walk_down"):
		direction.y += 1
	if Input.is_action_pressed("walk_left"):
		direction.x -= 1
	if Input.is_action_pressed("walk_right"):
		direction.x += 1
	return direction.normalized()

static func is_movement_input() -> bool:
	return movement_input() != Vector2.ZERO

static func is_grab_pressed() -> bool:
	return Input.is_action_pressed("grab")  

static func is_drop_just_pressed() -> bool:
	return Input.is_action_just_pressed("drop")  
