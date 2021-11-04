extends Button

onready var battleMenu = load("res://UI/Battle/battleMenuBanner.tscn").instance()

func _on_Button_toggled(button_pressed):
	if button_pressed:
		add_child(battleMenu)
		battleMenu 
		print("battle menu called")
		get_tree().paused = true
	else:
		hide()
