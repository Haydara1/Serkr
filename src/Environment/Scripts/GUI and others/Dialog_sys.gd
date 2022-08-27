extends CanvasLayer

var next = false

func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		next = true
	elif Input.is_action_just_pressed("hit"):
		read_file()

func read_file():
	var file = File.new()
	file.open("res://Timelines/Hello_world.txt", File.READ)
	var content = file.get_csv_line('?')
	display_dialog(content)
	file.close()
	

func display_dialog(content):
	for i in content:
		$ColorRect/Label.text = str(i)
		#$ColorRect/Label/Text_animation.play("text_visibility")
		print(i)
		
		while !next:
			pass
		
		next = false
