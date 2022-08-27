extends KinematicBody2D

var health = 3
var velocity = Vector2.ZERO
var speed = 50
var acceleration = 50

var follow_player = false
var stand = false

onready var player = get_tree().get_current_scene().get_node("YSort/Player")
onready var main_sprite = $Main_sprite
onready var collision_shape = $Collision_shape

func _ready():
	randomize()

func _physics_process(delta):
	if follow_player:
		var direction = (player.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
		
		if direction.x < 0:
			main_sprite.set_flip_h(true)
		else:
			main_sprite.set_flip_h(false)
		
		velocity = move_and_slide(velocity)
	else:
		if !stand:
			var _ignore_collisions = move_and_slide(velocity * delta * 2000) 

func take_damage(damage):
	health -= damage
	
	if health <= 0:
		die()
	else:
		knockback()

func die():
	$Main_sprite.visible = false
	$Death_effect.visible = true
	
	$AnimationPlayer.play("Death_effect")
	
	speed = 0
	collision_shape.disabled = true

func _on_Check_player_area_body_entered(body):
	if body.is_in_group("player"):
		follow_player = true

func _on_Movement_timer_timeout():
	var rand_check = randi() % 10 + 1
	
	velocity.x = randf()
	velocity.y = randf()
	velocity = velocity.normalized()
	
	if rand_check % 2 == 0 :
		
		var rand_num = randi() % 4 + 1
		
		if rand_num == 1:
			velocity.x = -velocity.x
			main_sprite.set_flip_h(true)
			
		elif rand_num == 2:
			velocity.y = -velocity.y
			main_sprite.set_flip_h(false)
			
		else:
			main_sprite.set_flip_h(false)
		
		velocity = velocity.normalized()
		stand = false
	else:
		stand = true

func knockback():
	var x_position = player.position.x - position.x
	var y_position = player.position.y - position.y
	
	if abs(x_position) > abs(y_position):
		if x_position > 0:
			velocity.x -= 100
		else:
			velocity.x += 100
	else:
		if y_position > 0 :
			velocity.y -= 100
		else:
			velocity.y += 100
