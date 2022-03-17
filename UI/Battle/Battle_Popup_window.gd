extends WindowDialog

onready var battleBannerScene = load("res://UI/Battle/Battle_Banner.tscn").instance()

func _ready():
	EventBus.connect("start_button_pressed",self, "_on_Battle_Panel_battleStart")
	EventBus.connect("battle_button_pressed",self,"battleMenuShow")

func _on_Battle_Panel_battleStart():
	print("Start Button Pressed")
	queue_free()
	var battleBanner = battleBannerScene
	get_parent().add_child(battleBanner)
	battleBanner

func battleMenuShow():
	EventBus.emit_signal("battle_menu_opened")
	visible = true
	popup_centered()
	if visible == true:
		get_tree().paused = true
	else:
		get_tree().paused = false

func _on_WindowDialog_popup_hide():
	get_tree().paused = false
	print("Battle Menu Closed")
	EventBus.emit_signal("battle_menu_closed")
