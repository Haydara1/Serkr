extends Node2D

onready var canvas_layer = $Main_Canvas_Layer

func _on_Door_body_entered(_body):
	var _change_tree = get_tree().change_scene("res://Environment/Main.tscn")

func _on_Dialogue_area_area_entered(_area):
	pass
