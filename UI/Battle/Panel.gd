extends PopupDialog

#onready var mobSpawn = load("res://Characters/Enemies/Mob_Spawner.tscn").instance()

func _ready():
	EventBus.connect("battle_menu_closed",self,"_diplay")

func _diplay():
	visible = true
	EventBus.emit_signal("battle_banner_opened")
	print("Battle Banner Opened")
	if visible == true:
		popup_centered_minsize(Vector2(2,2))
#		get_tree().paused = true
#	else:
#		get_tree().paused = false
	var t = Timer.new()
	t.set_wait_time()
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	#visible = false

func _on_Panel_about_to_show():
	visible = true

func _on_Timer_timeout():
	queue_free()
#	mobSpawn()

#func mobSpawn():
#	get_tree().get_root().add_child(mobSpawn)
#	mobSpawn

func _on_Panel_popup_hide():
	visible = false
