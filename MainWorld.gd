extends Node2D

onready var ground = $Ground
onready var pathFinding = $PathFinding
onready var mobSpawner = $MobSpawn

func _ready() -> void:
	pathFinding.createNavigationMap(ground)
	
	mobSpawner.initialize(pathFinding)
