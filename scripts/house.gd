extends Area2D

@export var house_id: String = "No.101"  # set in editor for each house
@onready var label: Label = $Label

func _ready() -> void:
	label.visible = false

func _process(_delta: float) -> void:
	if has_overlapping_bodies():
		var player = get_overlapping_bodies()[0] as Player
		if player and player.is_carrying and GameInputEvents.is_drop_just_pressed():
			if player.current_package == house_id:
				GameManager.add_score(5)
				$DeliverSound.play()
				$ParticleSystem.emitting = true  # trigger confetti
			else:
				$IncorrectSound.play()
				if GameManager.score >= 5:
					GameManager.add_score(-3)
				# no penalty if score < 5
			player.drop_package()
		label.visible = has_overlapping_bodies()
	else:
		label.visible = false
