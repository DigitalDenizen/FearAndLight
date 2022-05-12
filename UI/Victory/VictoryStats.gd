extends WindowDialog

onready var enemiesKilled = $GridContainer/MarginContainer/CenterContainer/Stats_container/Killed/VBoxContainer/Enemies_Killed/Panel/HBoxContainer/CenterContainer/HBoxContainer/Label2
onready var heroesKilled = $GridContainer/MarginContainer/CenterContainer/Stats_container/Killed/VBoxContainer/Heros_Killed/Heros_Killed/HBoxContainer/CenterContainer/HBoxContainer/Label2
onready var defensesKilled = $GridContainer/MarginContainer/CenterContainer/Stats_container/Killed/VBoxContainer/Defenses_destroyed/Defenses_Destroyed/HBoxContainer/CenterContainer/HBoxContainer/Label2


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("victory",self,"waveSpawnVictory")
	visible = false

func waveSpawnVictory(enemies, heroes, defenses):
	enemiesKilled.text = str(enemies)
	heroesKilled.text = str(heroes)
	defensesKilled.text = str(defenses)
	get_tree().paused = true
	visible = true

func closeWindow():
	get_tree().paused = false
