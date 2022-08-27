extends KinematicBody2D

onready var player = get_parent().get_node('Player')  #get_tree().get_current_scene().get_node("YSort/Player")
onready var animation_tree = $Elf_movement_tree
onready var animation_state = animation_tree.get("parameters/playback")

var player_near = true

var acceleration = 100
var Speed = 200
var node_name = "Elf"

var velocity = Vector2.ZERO
var player_angle = Vector2.ZERO

func _ready():
	animation_state.travel("Stand")
	print(player)

func _physics_process(delta):
	var direction = (player.global_position - self.global_position).normalized()
	velocity = velocity.move_toward(direction * Speed / 2, acceleration * delta)
	
	player_angle = player.position - self.position
	player_angle = player_angle.normalized()

	animation_tree.set("parameters/Stand/blend_position", player_angle)
	animation_tree.set("parameters/Walk/blend_position", player_angle)
	
	if player_near == false:
		velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player_near = true
		animation_state.travel("Stand")

func _on_Area2D_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_near = false
		animation_state.travel("Walk")
