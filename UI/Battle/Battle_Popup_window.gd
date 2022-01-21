extends WindowDialog
var battleMenuClosed
signal battleMenuClosed

signal startBattle
var battleMenuCalled = false

func _ready():
	if visible == true:
		popup_centered()

func _on_startBattle_battleMenuButtonPressed():
	visible = true
	if visible == true:
		popup_centered()

func _on_TabContainer_battleStart():
	#When the Start button is pressed a timer start
	#Once the timer runs out the menu closes and emaits a signal
	if visible == true:
		var t = Timer.new()
		t.set_wait_time(.5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		visible = false
		queue_free()
		battleMenuClosed = true
		emit_signal("battleMenuClosed")
		emit_signal("startBattle")
		print("Step: 3 - start battle")
