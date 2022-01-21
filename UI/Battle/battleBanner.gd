extends PopupDialog

onready var battleStart

signal bannerClosed

func _process(delta):
	if visible == true: 
		battleStart = true
		popup_centered() #When banner is visible center align
		_on_Control_battleMenuClosed()
		closeBanner()

func closeBanner():
	#When the banner is visible a timer is started
	#Once timed out the banner is closed and emit a signal
	#This is the signal that tiggers the Mob Spawn
	if visible == true:
		var t = Timer.new()
		t.set_wait_time(3) #Setting timer
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free() #Close timer
		queue_free() #close banner
		emit_signal("bannerClosed")
		get_tree().paused = false
		print("banner closed")

func _on_Control_battleMenuClosed():
	visible = true
