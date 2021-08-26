extends Button

onready var battleMenu_scene = preload("res://UI/Battle/Battle_Popup_window.tscn")

func _ready():
	pass

func _process(_delta):
	pass

func _on_Battle_Button__toggled(button_pressed):
	if button_pressed: 
		var battleMenu = battleMenu_scene.instance()
		add_child(battleMenu)
		battleMenu
