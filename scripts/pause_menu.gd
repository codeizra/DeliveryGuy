extends Control

signal resume_pressed
signal main_menu_pressed

func _ready() -> void:
	visible = false
	$VBoxContainer/ResumeButton.pressed.connect(_on_resume_button_pressed)
	$VBoxContainer/MainMenuButton.pressed.connect(_on_main_menu_button_pressed)

func _on_resume_button_pressed() -> void:
	print("PauseMenu: Resume button pressed")
	emit_signal("resume_pressed")

func _on_main_menu_button_pressed() -> void:
	print("PauseMenu: Main Menu button pressed")
	emit_signal("main_menu_pressed")
