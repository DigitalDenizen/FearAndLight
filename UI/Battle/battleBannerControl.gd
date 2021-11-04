extends Control

signal battleMenuClosed
signal bannerClosed

func _ready():
	pass # Replace with function body.

func _on_Control_battleMenuClosed():
	emit_signal("battleMenuClosed")

func _on_Panel_bannerClosed():
	emit_signal("bannerClosed")
