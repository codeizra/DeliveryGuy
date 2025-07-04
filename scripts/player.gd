class_name Player
extends CharacterBody2D

var player_direction : Vector2 = Vector2.ZERO
var is_carrying : bool = false
var current_package : String = "" #ex: No.102 (house destination)
var speed : float = 150.0

func _ready() -> void:
	pass
	
func pick_up_package(package_destination: String) -> void:
	is_carrying = true
	current_package = package_destination
	
func drop_package() -> void:
	is_carrying = false
	current_package = ""
