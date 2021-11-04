extends Control

signal bannerClosed
signal battleMenuButtonPressed

onready var batleBanner = load("res://UI/Battle/battleBanner.tscn").instance()

func _on_Control_battleMenuClosed():
	batleBanner
	add_child(batleBanner)

func _on_BattleBanner_bannerClosed():
	emit_signal("bannerClosed")

func _on_Button_toggled(button_pressed):
	emit_signal("battleMenuButtonPressed")
