extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	
	if direction != Vector2.ZERO:
		player.player_direction = direction
		animated_sprite_2d.play("walk" if !player.is_carrying else "carry")
		animated_sprite_2d.flip_h = direction.x < 0
	else:
		animated_sprite_2d.play("idle" if !player.is_carrying else "carry")
	
	player.velocity = direction * player.speed
	player.move_and_slide()

func _on_next_transitions() -> void:
	if not GameInputEvents.is_movement_input():
		transition.emit("Idle")
	if player.is_carrying and GameInputEvents.is_drop_just_pressed():
		transition.emit("Idle")  # drop package resets to idle

func _on_enter() -> void:
	animated_sprite_2d.play("walk" if not player.is_carrying else "carry")

func _on_exit() -> void:
	pass
