extends CanvasLayer

signal bannerClosed
onready var battleMenu = load("res://UI/Battle/battleMenu.tscn")
onready var battleBanner = load("res://UI/Battle/battleBanner.tscn").instance()
onready var mobSpawner = load("res://Characters/Enemies/MobSpawnerStartBattle.tscn")
onready var battleButton = $battleButton

func _ready():
	pass # Replace with function body.

func _on_BattleBanner_bannerClosed():
	emit_signal("bannerClosed")
	print("Banner Closed")
