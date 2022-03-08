extends Node2D

onready var ground = $Ground
onready var pathFinding = $PathFinding
onready var mobSpawner = $MobSpawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pathFinding.createNavigationMap(ground)
	
	mobSpawner.initialize(pathFinding)

	EventBus.connect("build_menu_opened",self, "on_build_menu_opened")
	EventBus.connect("build_menu_closed",self, "on_build_menu_closed")
	
func on_build_menu_opened():
	get_tree().paused = true
	
func on_build_menu_closed():
	get_tree().paused = false
