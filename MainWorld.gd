extends Node2D

onready var ground = $Ground
onready var pathFinding = $PathFinding
onready var mobSpawner = $Mob_Spawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pathFinding.create_navigation_map(ground)
	
	mobSpawner.initialize(pathFinding)
