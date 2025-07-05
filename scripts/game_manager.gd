extends Node

var score: int = 0
var highscore: int = 0

func _ready() -> void:
	load_highscore()

func add_score(points: int) -> void:
	score += points
	if score < 0:
		score = 0

func check_and_save_highscore() -> void:
	if score > highscore:
		highscore = score
		save_highscore()

func reset_score() -> void:
	score = 0

func load_highscore() -> void:
	var config = ConfigFile.new()
	var err = config.load("user://save.cfg")
	if err == OK:
		highscore = config.get_value("scores", "highscore", 0)
	else:
		highscore = 0

func save_highscore() -> void:
	var config = ConfigFile.new()
	config.set_value("scores", "highscore", highscore)
	config.save("user://save.cfg")
