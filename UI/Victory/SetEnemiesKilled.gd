extends Label

func _ready() -> void:
	EventBus.connect("set_enemies_killed", self, "_set_enemies_killed")

func _set_enemies_killed(value):
	self.text = value

