extends Node2D

onready var ground = $Ground
onready var pathFinding = $PathFinding
onready var mobSpawner = $MobSpawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pathFinding.createNavigationMap(ground)
	
	mobSpawner.initialize(pathFinding)
