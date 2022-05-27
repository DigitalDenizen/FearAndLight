extends Label

func _ready() -> void:
	EventBus.connect("set_heroes_killed", self, "_set_heroes_killed")

func _set_heroes_killed(value):
	self.text = value
