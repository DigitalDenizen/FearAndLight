extends Node2D

func _ready() -> void:
	EventBus.connect("close_toolbar", self, "_close_toolbar")

func _close_toolbar():
	print("Close Toolbar Hit!!!")
	remove_child($GridContainer)
