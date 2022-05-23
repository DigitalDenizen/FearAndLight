extends Button

func _on_Play_Button_button_up():
	print("This shit is pressable")
	get_tree().change_scene("res://MainWorldOpen.tscn")
