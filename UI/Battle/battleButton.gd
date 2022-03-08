extends Button

onready var battleMenuScene = load("res://UI/Battle/battleMenu.tscn")

func _ready():
	EventBus.connect("battle_menu_closed",self,"_on_Button_toggled")

func _on_Button_toggled(button_pressed):
	var battleMenu = battleMenuScene.instance()
	get_owner().add_child(battleMenu)
	if button_pressed == true:
		EventBus.emit_signal("battle_button_pressed")
		print("Battle Button Pressed")
	else:
		button_pressed
	
