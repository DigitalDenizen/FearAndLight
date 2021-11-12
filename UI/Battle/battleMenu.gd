extends Control
signal battleMenuButtonPressed

func _ready():
	pass # Replace with function body.

func _on_startBattle_battleMenuButtonPressed():
	emit_signal("battleMenuButtonPressed")
