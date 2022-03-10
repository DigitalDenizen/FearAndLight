extends Button

onready var battleBanner = preload("res://UI/Battle/Battle_Banner.tscn")

var startBattle
 
func _ready():
	EventBus.connect("battle_menu_opened",self,"_on_Button_toggled")

func _on_Button_toggled(button_pressed):
	EventBus.emit_signal("start_button_pressed")
	if button_pressed == true:
#		var t = Timer.new()
#		t.set_wait_time(.5)
#		t.set_one_shot(true)
#		self.add_child(t)
#		t.start()
#		yield(t, "timeout")
#		t.queue_free()
#		visible = false
#		queue_free()
		print("pressed")
