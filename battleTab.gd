extends TabContainer
signal battleStart

func _ready():
	pass # Replace with function body.


func _on_Battle_Panel_battleStart():
	emit_signal("battleStart")
