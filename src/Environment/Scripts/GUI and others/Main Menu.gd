extends Node2D

onready var new_game_button = $New_game_button
onready var continue_button = $Continue_button
onready var settings_button = $Settings_button

func _ready():
	new_game_button.connect("pressed", get_tree().current_scene, "New_game")
	settings_button.connect("pressed", get_tree().current_scene, "Settings")
	continue_button.connect("pressed", get_tree().current_scene, "Continue")
	if get_tree().current_scene.get_existing_data():
		continue_button.disabled = false
