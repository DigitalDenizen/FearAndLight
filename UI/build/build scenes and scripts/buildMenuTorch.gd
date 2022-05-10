extends Panel

func _on_slot_main_button_button_up():
	print("torch")
	EventBus.emit_signal("placing_torch")
