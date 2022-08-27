extends Node2D

onready var name_label = $Name_Label

var player_name = ""
var helper = ""

var caps = false
var index = 0
var final_name = ""

var story_scene = preload("res://Environment/Scenes/Story_scenes/Story.tscn")

var letters = "QWERTYUIOPASDFGHJKLZXCVBNNM_"

signal save_game
signal next_scene(story_scene)

func _ready():
	for button in $Buttons.get_children():
		button.connect("pressed", self, "Button_pressed", [button.text])
	
	var _bin = self.connect("save_game", get_tree().current_scene, "Save_game")
	
	_bin = $Return_button.connect("pressed", get_tree().current_scene, "main_menu_scene")
	_bin = self.connect("next_scene", get_tree().current_scene, "next_scene")
	

func Button_pressed(button_text):
	if button_text == "Backspace":
		
		for i in range(len(player_name) - 1):
			helper += player_name[i]
		
		player_name = helper
		helper = ""
		
		index = max(index-1, 0)
		
	elif button_text == "Caps Lock":
		caps = !caps
	else:
		if index < 8:
			if caps:
				button_text = button_text.to_upper()
			else:
				button_text = button_text.to_lower()
				index += 1
		else:
			return
			
		player_name += button_text
	
	name_label.text = str(player_name)


func _on_Continue_button_pressed():
	if index < 1:
		return
	
	final_name = player_name
	var scene_holder = get_tree().current_scene
	scene_holder.set_player_name(final_name)
	
	emit_signal("next_scene", story_scene)
	emit_signal("save_game")
	
	queue_free()

func _input(event):
	if event is InputEventKey:
		if event.as_text() in letters:
			if index > 8:
				return
			
			if caps:
				player_name += event.as_text()
			else:
				player_name += event.as_text().to_lower()
			index += 1
		elif event.scancode == KEY_BACKSPACE:
			for i in range(len(player_name) - 1):
				helper += player_name[i]
		
			player_name = helper
			helper = ""
		
			index = max(index-1, 0)
		elif event.scancode == KEY_CAPSLOCK:
			caps = !caps
		
		name_label.text = str(player_name)
		
		set_process_input(false)
		yield(get_tree().create_timer(0.2), "timeout")
		set_process_input(true)
	 
