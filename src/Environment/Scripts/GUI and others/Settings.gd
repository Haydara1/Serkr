extends CanvasLayer

func _ready():
	get_tree().paused = true

func _on_Resume_Button_pressed():
	get_tree().paused = false
	self.queue_free()

func _on_Quit_button_pressed():
	get_tree().quit()
	
func _on_Save_Button_pressed():
	get_tree().current_scene.Save_game()
