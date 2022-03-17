extends Button

onready var battleMenu = load("res://UI/Battle/battleMenu.tscn").instance()

func _ready():
	EventBus.connect("battle_menu_opened",self,"_on_Button_toggled")

func _on_Button_toggled(button_pressed):
	#Util.get_node("res://UI/Battle/battleMenu.tscn")
	get_parent().add_child(battleMenu)
	battleMenu
	if button_pressed == true:
		EventBus.emit_signal("battle_button_pressed")
		print("Battle Button Pressed")
		button_pressed = false
