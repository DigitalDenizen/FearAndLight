extends PopupDialog

func _ready():
	EventBus.connect("battle_menu_closed",self,"_showBattlePanel")

func _process(delta):
	if visible == true:
		popup_centered()

func closeBanner():
	if visible == true:
		var t = Timer.new()
		t.set_wait_time(2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		queue_free()
		on_battleBannerClose()

func _showBattlePanel():
	visible = true
	EventBus.emit_signal("battle_banner_opened")
	print("Battle Banner Opened")
	closeBanner()

func _on_Timer_timeout():
	queue_free()

func on_battleBannerClose():
	EventBus.emit_signal("battle_banner_closed")
	print("Battle Banner Closed")
	visible = false
