extends Node2D

@onready var highscore_label: Label = $VBoxContainer/HighscoreLabel
@onready var music_player: AudioStreamPlayer2D = $MusicPlayer


func _ready() -> void:
	highscore_label.text = "Highscore: %d" % GameManager.highscore
	
func _on_music_finished():
	music_player.play()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/delivery_game.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

