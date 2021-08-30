extends PanelContainer
signal battleStart()

func _ready():
	
	pass # Replace with function body.

func _process(delta):
	pass

func _on_Start_Battle_toggled(button_pressed):
	if button_pressed == true:
		emit_signal("battleStart")
		
