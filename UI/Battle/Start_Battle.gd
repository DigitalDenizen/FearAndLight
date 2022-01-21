extends Button
signal battleStart

func _on_Button_toggled(button_pressed):
	if button_pressed == true:
		emit_signal("battleStart")
		print("Step: 1 - Start Battle Pressed")
