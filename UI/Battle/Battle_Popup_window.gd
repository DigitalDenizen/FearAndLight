extends WindowDialog

var startBattle

onready var battleBannerScene = load("res://UI/Battle/Battle_Banner.tscn")

func _ready():
	EventBus.connect("battle_button_pressed",self,"battleMenuShow")
	EventBus.connect("battle_menu_closed",self,"_on_Battle_Panel_battleStart")
	EventBus.connect("start_button_pressed",self, "_on_Battle_Panel_battleStart")

func _on_Battle_Panel_battleStart():
	var t = Timer.new()
	t.set_wait_time(1)
	queue_free()
	EventBus.emit_signal("battle_menu_closed")
	var battleBanner = battleBannerScene.instance()
	get_owner().add_child(battleBanner)
	print("startBattle")

func battleMenuShow():
	visible = true
	popup_centered()
	if visible == true:
		get_tree().paused = true
	else:
		get_tree().paused = false

func _on_WindowDialog_popup_hide():
	get_tree().paused = false
	EventBus.emit_signal("battle_menu_closed")
	print("Battle Menu Closed")
