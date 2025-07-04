extends Control

signal play_again_pressed
signal main_menu_pressed

func _ready() -> void:
	visible = false
	$VBoxContainer/PlayAgainButton.pressed.connect(_on_play_again_button_pressed)
	$VBoxContainer/MainMenuButton.pressed.connect(_on_main_menu_button_pressed)

func set_score(score: int) -> void:
	$VBoxContainer/ScoreLabel.text = "Score: %d" % score

func set_highscore(highscore: int) -> void:
	$VBoxContainer/HighscoreLabel.text = "Highscore: %d" % highscore

func _on_play_again_button_pressed() -> void:
	print("GameOverMenu: Play Again button pressed")
	emit_signal("play_again_pressed")

func _on_main_menu_button_pressed() -> void:
	print("GameOverMenu: Main Menu button pressed")
	emit_signal("main_menu_pressed")
