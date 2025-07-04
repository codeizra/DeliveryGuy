extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	animated_sprite_2d.play("idle" if not player.is_carrying else "carry")

func _on_next_transitions() -> void:
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")
	if player.is_carrying and GameInputEvents.is_drop_just_pressed():
		transition.emit("Idle")  # drop package resets to idle

func _on_enter() -> void:
	animated_sprite_2d.play("idle" if not player.is_carrying else "carry")

func _on_exit() -> void:
	pass
