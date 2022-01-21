extends Panel

signal battleStart()

func _on_Button_toggled(button_pressed):
	if button_pressed == true:
		emit_signal("battleStart")
		print("Connect #1")
