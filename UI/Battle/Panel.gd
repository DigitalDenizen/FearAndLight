extends PopupDialog

#onready var mobSpawn = load("res://Characters/Enemies/Mob_Spawner.tscn").instance()

func _ready():
	EventBus.connect("battle_menu_closed",self,"_showBattlePanel")

func _process(delta):
	if visible == true:
		popup_centered()


func display():
	if visible == true:
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		#_on_Panel_popup_hide()

func _showBattlePanel():
	visible = true
	EventBus.emit_signal("battle_banner_opened")
	print("Battle Banner Opened")
	display()

func _on_Timer_timeout():
	queue_free()
#	mobSpawn()

#func mobSpawn():
#	get_tree().get_root().add_child(mobSpawn)
#	mobSpawn

func _on_Panel_popup_hide():
	EventBus.emit_signal("battle_banner_closed")
	visible = false
