extends Panel

func _on_slot_main_button_button_up():
	print("large wall")
	EventBus.emit_signal("placing_large_wall")
