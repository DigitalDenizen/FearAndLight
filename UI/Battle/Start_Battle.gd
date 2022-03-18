extends Button

func _on_Button_toggled(button_pressed):
	EventBus.emit_signal("start_button_pressed")

