extends Area2D

export(PackedScene) var target_scene

func _ready():
	add_to_group("Doors")
	
func _input(event):
	if event.is_action_pressed("shoot") || event.is_action_pressed("melee"):
		if !target_scene: # is null
			print ("no scene is this door")
			return
		if get_overlapping_bodies().size() > 0:
			next_level()
			
func next_level():
	var ERR = get_tree().change_scene_to(target_scene)
