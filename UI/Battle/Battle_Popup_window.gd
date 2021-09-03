extends WindowDialog

var startBattle
onready var battleBanner_scene = preload("res://UI/Battle/Battle_Banner.tscn")

func _process(delta):
	if visible == true:
		popup_centered_minsize(Vector2(250,136))
		

func _on_Battle_popup_visibility_changed():
	if visible == false:
		hide()


func battleBanner():
	var battleBanner = battleBanner_scene.instance()
	add_child(battleBanner)
	battleBanner 

func _on_Battle_Panel_battleStart():
	startBattle = true
	print("startBattle")
	if startBattle == true:
		visible = false
		battleBanner()
