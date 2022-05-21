extends Button

func _ready():
	add_to_group("UI")

func _on_Play_Button_button_up():
	get_tree().change_scene("res://MainWorld.tscn")
	
