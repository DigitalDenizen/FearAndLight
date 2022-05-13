extends Button



func _on_Button_toggled(button_pressed: bool) -> void:
	print("Button Toggled")
	EventBus.emit_signal("toggle_inventory", true)
