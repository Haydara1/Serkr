extends Node2D

var bat = preload("res://Characters/Sprites/Enemies/Bat.tscn")

func _on_Enemy_spaw_time_timeout():
	var bat_instance = bat.instance()
	add_child(bat_instance)
