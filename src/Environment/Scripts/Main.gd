extends Node2D

onready var flowers_group = $YSort/FLowers
onready var grass_group = $YSort/Grass

onready var Grass_corner_position1 = $Grass_corner_first
onready var Grass_corner_position2 = $Grass_corner_second

onready var messages_label = $Main_Canvas_Layer/Messages
onready var elf = $YSort/Elf

var flower = preload("res://Environment/Scenes/Environment/Flowers.tscn")
var grass = preload("res://Environment/Scenes/Environment/Grass.tscn")

var path = "res://Environment/Scenes/areas/area_1/Three_houses.tscn" setget ,get_level_path

func _ready():
	randomize()
	
	for _x in range(25):
		var flower_instance = flower.instance()
		var grass_instance = grass.instance()
		
		flowers_group.add_child(flower_instance)
		grass_group.add_child(grass_instance)
	
	for flower in flowers_group.get_children():
		var position = Vector2.ZERO
		position.x = rand_range(Grass_corner_position1.position.x, Grass_corner_position2.position.x)
		position.y = rand_range(Grass_corner_position1.position.y, Grass_corner_position2.position.y)
		
		flower.set_position(position)
		flower.frame = rand_range(1, 15)
	
	for grass in grass_group.get_children():
		var position = Vector2.ZERO
		position.x = rand_range(Grass_corner_position1.position.x, Grass_corner_position2.position.x)
		position.y = rand_range(Grass_corner_position1.position.y, Grass_corner_position2.position.y)
		
		grass.set_position(position)
		grass.frame = rand_range(16, 30)

func _on_Players_area_body_entered(body):
	if body.is_in_group("NPC"):
		var name = body.node_name
		if name == "Peasent":
			messages_label.text = "Some villagers don't like to interact with strangers."
		
			yield(get_tree().create_timer(5.0), "timeout")
			messages_label.text = ""
		
		elif name == "Elf":
			pass

func get_level_path():
	return path

func _on_Door_body_entered(body):
	if body.is_in_group("player"):
		var _change_tree = get_tree().change_scene("res://Environment/Scenes/House_interior.tscn")

func Hello(_value):
	print("Hello")
