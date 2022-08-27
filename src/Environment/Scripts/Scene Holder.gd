extends Node2D

var Main_menu = preload("res://Environment/Scenes/GUI/Main Menu.tscn")
var Settings_CL = preload("res://Environment/Scenes/GUI/Settings.tscn")
var get_player_name_scene = preload("res://Environment/Scenes/GUI/New_game_scene.tscn")
var village_center = preload("res://Environment/Scenes/areas/area_1/Three_houses.tscn")

onready var save_state = $Color_rect_Save_state

var player_name = "Gatsu" setget set_player_name, get_player_name
var existing_data = false setget ,get_existing_data

signal save_game
signal load_game

func _ready():
	var _bin = self.connect("save_game", save_state, "save_game")
	_bin = self.connect("load_game", save_state, "load_game")

func _input(_event):
	main_menu_scene()
	set_process_input(false)
#	if event.is_action_pressed("ui_cancel"):
#		Settings()

func set_player_name(pl_nm):
	player_name = pl_nm

func get_player_name():
	return player_name

func get_existing_data():
	return existing_data

func New_game():
	new_scene(get_player_name_scene)

func Settings():
	add_child(Settings_CL)

func Continue():
	emit_signal("load_game")

func Save_game():
	emit_signal("save_game")

func main_menu_scene():
	new_scene(Main_menu)

func new_scene(scene_name):
	$Color_rect_Save_state/AnimationPlayer.play("Fade_in")
	
	for child in self.get_children():
		if child.is_in_group("Perm"):
			continue
		else:
			child.queue_free()
	
	add_child_below_node($Scene_fade, scene_name.instance())
#	add_child(scene_name)
#	print(get_children())

func get_save_stats():
	var path = ""
	
	var level = get_tree().get_nodes_in_group("Level")
	if level != null and not level.empty():
		path = level[0].get_level_path()
	
	return {
		'filename' : filename,
		'player_name' : player_name,
		'level' : path
	}

func load_save_stats(stats):
	set_player_name(stats.player_name)
	
	var level = load(stats.level)
	
	add_child(level.instance())
#	new_scene(level)

func _on_existing_data():
	existing_data = true

func Start_game():
	new_scene(village_center)

func next_scene(scene):
	add_child(scene.instance())
