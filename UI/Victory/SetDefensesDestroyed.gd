extends Label

func _ready() -> void:
	EventBus.connect("set_defenses_destroyed", self, "_set_defenses_destroyed")

func _set_defenses_destroyed(value):
	self.text = value

