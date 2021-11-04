extends Control

signal battleMenuClosed
signal startBattleBanner
signal startBattle

export (bool) var battleMenuClosed

func _process(delta):
	_on_WindowDialog_startBattle()

func _on_WindowDialog_startBattle():
	emit_signal("startBattle")

func _on_WindowDialog_popup_hide():
	emit_signal("battleMenuClosed")
	print("closed")
