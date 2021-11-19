extends Control

signal bannerClosed
signal battleMenuButtonPressed

onready var batleBanner = load("res://UI/Battle/battleBanner.tscn").instance()

func _on_Control_battleMenuClosed():
	batleBanner
	add_child(batleBanner)

func _on_Button_toggled(button_pressed):
	emit_signal("battleMenuButtonPressed")

func _on_CenterContainer2_bannerClosed():
	emit_signal("bannerClosed")
