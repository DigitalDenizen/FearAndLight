extends Panel

onready var gold_nugget = preload("res://UI/build/ui-build-res-gold-nuggets-sm.png")
onready var mud_clumps = preload("res://UI/build/ui-build-res-mud-clumps-sm.png")
onready var wall = load("res://UI/build/build scenes and scripts/mud_wall_position.tscn").instance()
onready var mudhut = load("res://UI/build/build scenes and scripts/mud_hut_position.tscn").instance()

func _ready():
	pass
	#_populate_mudhut()
	#_populate_wall()
