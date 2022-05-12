extends Panel

func _on_slot_main_button_button_up():
	print("bomb barrel")
	EventBus.emit_signal("placing_bomb_barrel")
