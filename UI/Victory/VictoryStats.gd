extends WindowDialog

onready var enemiesKilled = $GridContainer/MarginContainer/CenterContainer/Stats_container/Killed/VBoxContainer/Enemies_Killed/Panel/HBoxContainer/CenterContainer/HBoxContainer/Label2
onready var heroesKilled = $GridContainer/MarginContainer/CenterContainer/Stats_container/Killed/VBoxContainer/Heros_Killed/Heros_Killed/HBoxContainer/CenterContainer/HBoxContainer/Label2
onready var defensesKilled = $GridContainer/MarginContainer/CenterContainer/Stats_container/Killed/VBoxContainer/Defenses_destroyed/Defenses_Destroyed/HBoxContainer/CenterContainer/HBoxContainer/Label2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


func waveSpawnVictory(enemies, heroes, defenses):
	enemiesKilled.text = str(enemies)
	heroesKilled.text = str(heroes)
	defensesKilled.text = str(defenses)
	visible = true
