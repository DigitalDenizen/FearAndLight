extends Area2D

func _on_Click_area_input_event(viewport, event, shape_idx):
	if (event.type == InputEvent.MOUSEBUTTON && event.is_pressed and event.button_index == BUTTON_LEFT):
		print("Clicked")
