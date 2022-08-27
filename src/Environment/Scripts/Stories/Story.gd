extends Node2D

signal _finished

func _ready():
	$Label/AnimationPlayer.play("Visibility")
	var _bin = self.connect("_finished", get_tree().current_scene, "Start_game")

func _input(event):
	if event.is_action("ui_accept"):
		emit_signal("_finished")
		queue_free()
