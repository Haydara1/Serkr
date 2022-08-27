extends Area2D

func _on_Slowing_plant_body_entered(body):
	if body.is_in_group("Walkers"):
		body.Speed = 100

func _on_Slowing_plant_body_exited(body):
	if body.is_in_group("Walkers"):
		body.Speed = 200
