extends Button

onready var battleMenuScene = load("res://UI/Battle/battleMenu.tscn")

func _on_Button_toggled(button_pressed):
	var battleMenu = battleMenuScene.instance()
	add_child(battleMenu)
	if button_pressed:
		battleMenu
