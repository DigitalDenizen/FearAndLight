extends TileMap

var tile
#var build_ready

onready var wall = preload("res://Structures/MudWall.tscn")
const GRID_SIZE = Vector2(32, 32)

		
#this function adds an instance of the wall and locks it to a tile at mouse position	
func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var ins = wall.instance()
		self.add_child(ins)
		ins.global_position = get_global_mouse_position().snapped(GRID_SIZE)
		

#this function locks the child sprite to the mouse position
func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	tile = world_to_map(mouse_pos)
	$Panel/ScrollContainer/GridContainer/HBoxContainer/VBoxContainer/ItemList/CenterContainer/mud_wall_position/mud_wall.position = map_to_world(tile)

#	print (get_cellv(tile))
#
#
#	if get_cellv(tile) == 0:
#		build_ready = true
#		#print("zero")
#
#	else:
#		build_ready = false


#https://generalistprogrammer.com/godot/godot-spawn-object-or-scene-instancing-tutorial/
#https://godotengine.org/qa/30210/how-do-load-resource-works
#https://godotengine.org/qa/47174/sprite-click-position-with-grid-positioning-tilemap-editor
