extends Button

var startBattle
 
onready var battlePanel = load("res://UI/Battle/Battle_Panel.tscn")

func _process(delta):
	if pressed == true:
		pass
	else:
		pressed = false

func _on_Start_Battle_toggled(button_pressed):
	if button_pressed == true:
		battlePanel
		print("pressed")

