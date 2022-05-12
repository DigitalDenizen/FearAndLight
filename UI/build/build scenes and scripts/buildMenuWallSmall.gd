extends Panel

func _on_slot_main_button_button_up():
	print("small wall")
	EventBus.emit_signal("placing_small_wall")
