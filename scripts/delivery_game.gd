extends Node2D

@onready var destination_label: Label = $UI/DestinationLabel
@onready var score_label: Label = $UI/ScoreLabel
@onready var timer_label: Label = $UI/TimerLabel
@onready var timer: Timer = $Timer
@onready var music_player: AudioStreamPlayer2D = $MusicPlayer


var pause_menu: Control
var game_over_menu: Control

func _ready() -> void:
	timer.start()
	update_ui()
	
	# inst PauseMenu
	var pause_scene = preload("res://scenes/pause_menu.tscn")
	pause_menu = pause_scene.instantiate()
	$UI.add_child(pause_menu)
	pause_menu.resume_pressed.connect(_on_resume_button_pressed)
	pause_menu.main_menu_pressed.connect(_on_main_menu_button_pressed)
	pause_menu.visible = false
	
	# inst GameOverMenu
	var game_over_scene = preload("res://scenes/game_over_menu.tscn")
	game_over_menu = game_over_scene.instantiate()
	$UI.add_child(game_over_menu)
	game_over_menu.play_again_pressed.connect(_on_play_again_button_pressed)
	game_over_menu.main_menu_pressed.connect(_on_main_menu_button_pressed)
	game_over_menu.visible = false
	
	# connect truck signal
	$Truck.connect("package_picked", _on_package_picked)
	
	# debug
	print("PauseMenu:", pause_menu)
	print("GameOverMenu:", game_over_menu)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Mouse clicked at: ", event.position, " Paused: ", get_tree().paused)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.visible = !pause_menu.visible
		get_tree().paused = pause_menu.visible
		print("Pause toggled: ", get_tree().paused)
	update_ui()

func update_ui() -> void:
	destination_label.text = "Deliver to: %s" % ($Player.current_package if $Player.is_carrying else "None")
	score_label.text = "Score: %d" % GameManager.score
	timer_label.text = "Time: %.1f" % timer.time_left

func _on_package_picked(destination: String) -> void:
	update_ui()
	
func _on_music_finished() -> void:
	music_player.play()
	
func _on_timer_timeout() -> void:
	get_tree().paused = true
	game_over_menu.set_score(GameManager.score)
	game_over_menu.set_highscore(GameManager.highscore)
	game_over_menu.visible = true
	print("GameOverMenu shown")

func _on_resume_button_pressed() -> void:
	print("Resume button pressed")
	pause_menu.visible = false
	get_tree().paused = false
	print("Game paused: ", get_tree().paused)

func _on_play_again_button_pressed() -> void:
	print("Play Again button pressed")
	get_tree().paused = false
	GameManager.reset_score()
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed() -> void:
	print("Main Menu button pressed")
	get_tree().paused = false
	GameManager.reset_score()
	var error = get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	if error != OK:
		print("Failed to load main_menu.tscn, error: ", error)
