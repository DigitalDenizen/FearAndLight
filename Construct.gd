extends Node2D

func _ready():
	EventBus.connect("pause_game", self, "_on_pause_game")
	EventBus.connect("unpause_game", self, "_on_unpause_game")

func _on_pause_game():
	get_tree().paused = true
	
func _on_unpause_game():
	get_tree().paused = false

