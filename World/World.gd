extends Node2D

export (float) var max_health = 100
onready var health = max_health setget _set_health

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)

func _ready():
	add_to_group("TileMaps")

func hurt(damage):
	_set_health(health - damage)
