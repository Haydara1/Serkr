extends Camera2D

onready var player = get_parent().find_node("Player") #get_tree().get_current_scene().get_node("YSort/Player")

var shake_amount = 0.0
var shake_weight := 0.2

func _process(_delta):
	if shake_amount <= 0:
		position = player.position
	else:
		
		position.x = rand_range(-1, 1) * shake_amount + player.position.x
		position.y = rand_range(-1, 1) * shake_amount + player.position.y 
		
		shake_amount = lerp(shake_amount, -1, shake_weight)

func shake(magnitude: float):
	shake_amount = magnitude
