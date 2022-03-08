extends Panel


func _on_Start_Battle_toggled(button_pressed):
	if button_pressed == true:
		EventBus.emit_signal("start_button_pressed",self)
		print("Start button Pressed")

