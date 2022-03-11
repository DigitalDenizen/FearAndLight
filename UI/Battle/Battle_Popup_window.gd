extends WindowDialog

var startBattle

func _ready():
	if visible == true:
		popup_centered_minsize(Vector2(250,136)) 
		
func _on_Battle_popup_visibility_changed():
	if visible == false:
		hide() 

func _on_Battle_Panel_battleStart():
	startBattle = true
	print("startBattle")
	if startBattle == true:
		visible = false
