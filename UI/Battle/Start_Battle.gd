extends Button

onready var battleBanner = preload("res://UI/Battle/Battle_Banner.tscn")

var startBattle
 
func _ready():
	pass
func _on_Start_Battle_toggled(button_pressed):
	EventBus.emit_signal("start_button_pressed")
	if button_pressed == true:
		print("pressed")
