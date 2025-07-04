extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	
	if direction != Vector2.ZERO:
		player.player_direction = direction
		animated_sprite_2d.play("carry")
	else:
		animated_sprite_2d.play("carry")
	
	player.velocity = direction * player.speed
	player.move_and_slide()

func _on_next_transitions() -> void:
	if not player.is_carrying:
		transition.emit("Idle")
	if GameInputEvents.is_drop_just_pressed():
		transition.emit("Idle")  # dropping package

func _on_enter() -> void:
	animated_sprite_2d.play("carry")

func _on_exit() -> void:
	pass
