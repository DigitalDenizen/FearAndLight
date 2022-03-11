extends Panel

func _on_slot_main_button_button_up():
	EventBus.emit_signal("placing_mud_hut")
