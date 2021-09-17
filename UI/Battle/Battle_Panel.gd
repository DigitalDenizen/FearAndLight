extends PanelContainer

signal battleStart()

func _on_Start_Battle_toggled(button_pressed):
	if button_pressed == true:
		emit_signal("battleStart")
