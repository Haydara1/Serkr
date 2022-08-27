extends KinematicBody2D

onready var animation_tree = $Female_walk_tree
onready var animation_state = animation_tree.get("parameters/playback")
onready var Clamping_position1 = find_node("Grass_corner_first") #get_tree().get_current_scene().get_node("Grass_corner_first")
onready var Clamping_position2 = find_node("Grass_corner_second")#get_tree().get_current_scene().get_node("Grass_corner_second")

var velocity = Vector2.ZERO
var Speed = 200
var stand = true
var node_name = "Peasent"

func _ready():
	animation_state.travel("Stand")
	randomize()

func _physics_process(delta):
	animation_tree.set("parameters/Stand/blend_position", velocity)
	animation_tree.set("parameters/Walk/blend_position", velocity)
	
	if !stand:
		var _ignore_collisions = move_and_slide(velocity * delta * Speed * 10) 

func _on_Wander_timer_timeout():
	var rand_check = randi() % 10 + 1
	
	velocity.x = randf()
	velocity.y = randf()
	velocity = velocity.normalized()
	
	if rand_check % 2 == 0 :
		
		var rand_num = randi() % 4 + 1
		
		if rand_num == 1:
			velocity.x = -velocity.x
		elif rand_num == 2:
			velocity.y = -velocity.y
		
		velocity = velocity.normalized()
		
		animation_state.travel("Walk")
		
		stand = false
	
	else:
		animation_state.travel("Stand")
		stand = true
