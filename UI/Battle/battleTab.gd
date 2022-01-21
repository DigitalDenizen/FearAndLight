extends TabContainer
signal battleStart

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Button_battleStart():
	emit_signal("battleStart")
	print("Step: 2")
