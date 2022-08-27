extends KinematicBody2D

var velocity = Vector2.ZERO
var invincibility = false
var node_name = "Player"
var inventory = false

export var Speed = 200
export var health = 4

onready var animation_player = $Players_movement_animation
onready var animation_tree = $players_move_anim_tree
onready var animation_state = animation_tree.get("parameters/playback")

onready var hearts = $Full_hearts
onready var Invincibility_timer = $Invincibility_timer
onready var camera = get_parent().get_parent().find_node('Camera_main') #get_tree().current_scene.get_node("Camera_main")

signal took_item(item_name)

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("downward") - Input.get_action_strength("upward")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Walk/blend_position", input_vector)
		animation_tree.set("parameters/Sword_attack/blend_position", input_vector)
		
		$RayCast2D.cast_to = input_vector.normalized() * 40
		
		animation_state.travel("Walk")
		velocity = input_vector
	else:
		animation_state.travel("Idle")
		velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("hit"):
		hit()
	elif Input.is_action_pressed("run"):
		velocity  = move_and_collide(velocity * delta * Speed * 1.5)
	else:
		velocity = move_and_collide(velocity * delta * Speed)
	
	if Input.is_action_just_pressed("Inventory"):
		if inventory:
			$Inventory/TextureRect.hide()
			inventory = false
		else:
			$Inventory/TextureRect.show()
			inventory = true

func _on_Players_area_body_entered(_body):
	pass

func _on_Players_hurtbox_body_entered(body):
	if body.is_in_group("enemies"):
		take_damage(1)
	emit_signal("took_item", "hello")

func _on_Invincibility_timer_timeout():
	invincibility = false

func hit():
	animation_state.travel("Sword_attack")
	var target = $RayCast2D.get_collider()
	
	if target != null:
		if target.is_in_group("enemies"):
			target.take_damage(1)
			$Hit.play()
			
			camera.shake(10)
			
		elif target.is_in_group("Bush"):
			target.play_animation()

func take_damage(damage):
	if invincibility:
		pass
	else:
		health -= damage
		$Hurt.play()
		
		check_health(health)
		invincibility = true
		
		camera.shake(15) 
		Invincibility_timer.start()
		
		animation_player.play("Invincibility")
		
		if health <= 0:
			die()

func die():
	pass

func check_health(health):
	if health == 4:
		hearts.rect_size.x = 60
		
	elif health == 3:
		hearts.rect_size.x = 44
		
	elif health == 2:
		hearts.rect_size.x = 30
		
	elif health == 1:
		hearts.rect_size.x = 14
		
	else:
		hearts.rect_size.x = 0
