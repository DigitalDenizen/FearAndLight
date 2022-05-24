extends WindowDialog

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("defeat", self, "gameOverPanel")
	EventBus.connect("return_to_menu", self, "_return_to_menu")
	visible = false

func gameOverPanel():
	EventBus.emit_signal("set_enemies_killed", str(Score.vampSpiderStat + Score.zombieStat + Score.direWolfStat))
	EventBus.emit_signal("set_heroes_killed", "1")
	EventBus.emit_signal("set_defenses_destroyed", str(Score.buildingsDestroyed))
	popup_centered()
	visible = true

func closeWindow():
	get_tree().change_scene("res://UI/title-screen.tscn")
	
