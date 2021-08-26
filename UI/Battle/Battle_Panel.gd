extends PanelContainer
signal battleStart()

func _ready():
	pass

func _process(delta):
	pass

func _on_Start_Battle_toggled(button_pressed):
	if button_pressed == true:
		emit_signal("battleStart")
		
