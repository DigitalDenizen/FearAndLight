extends WindowDialog


func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if visible == true:
		popup_centered_ratio(.55)

func _on_Button_toggled(button_pressed):
	if button_pressed == true:
		visible = true

