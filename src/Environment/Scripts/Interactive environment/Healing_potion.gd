extends Node2D

func _on_Area2D_body_entered(body):
	if body.node_name == "Player":
		body.health = min(4, body.health + 1)
		queue_free()
