extends Area2D

signal package_picked(destination: String)

var destinations = ["No.101", "No.102", "No.103", "No.104", "No.105"]


func _process(_delta: float) -> void:
	if has_overlapping_bodies() and GameInputEvents.is_grab_pressed():
		var player = get_overlapping_bodies()[0] as Player
		if player and not player.is_carrying:
			player.pick_up_package(destinations[randi() % destinations.size()])
			emit_signal("package_picked", player.current_package)
			$PickupSound.play()
