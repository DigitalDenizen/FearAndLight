extends TileMap

const GRID_SIZE = Vector2(32, 32)
var tile


onready var mudHut = preload("res://Structures/MudHut.tscn")
var mudHutMouse = preload("res://UI/build/build scenes and scripts/mudHutPosition.tscn").instance()
var mudHutPlacement = 0

onready var largeWall = preload("res://Structures/MudWall.tscn")
var largeWallMouse = preload("res://UI/build/build scenes and scripts/largeWallPosition.tscn").instance()
var largeWallPlacement = 0

onready var smallWall = preload("res://Structures/SmallWall.tscn")
var smallWallMouse = preload("res://UI/build/build scenes and scripts/smallWallPosition.tscn").instance()
var smallWallPlacement = 0

onready var torch = preload("res://Structures/Torch.tscn")
var torchMouse = preload("res://UI/build/build scenes and scripts/torchPosition.tscn").instance()
var torchPlacement = 0

onready var bombBarrel = preload("res://Structures/BombBarrel.tscn")
var bombBarrelMouse = preload("res://UI/build/build scenes and scripts/bombBarrelPosition.tscn").instance()
var bombBarrelPlacement = 0

func _ready():
	EventBus.connect("placing_mud_hut", self, "_on_placing_mudhut")
	EventBus.connect("placing_large_wall", self, "_on_placing_large_wall")
	EventBus.connect("placing_small_wall", self, "_on_placing_small_wall")
	EventBus.connect("placing_torch", self, "on_placing_torch")
	EventBus.connect("placing_bomb_barrel", self, "on_placing_bomb_barrel")
	
func _on_placing_mudhut():
	print("placing mudhut")
	mudHutPlacement = 1
	EventBus.emit_signal("close_build_menu")
	visible = true
	
func _on_placing_large_wall():
	print("placing large wall")
	largeWallPlacement = 1
	EventBus.emit_signal("close_build_menu")
	visible = true
	
func _on_placing_small_wall():
	print("placing small wall")
	smallWallPlacement = 1
	EventBus.emit_signal("close_build_menu")
	visible = true

func on_placing_torch():
	print("placing torch")
	torchPlacement = 1
	EventBus.emit_signal("close_build_menu")
	visible = true
	
func on_placing_bomb_barrel():
	print("placing bomb barrel")
	bombBarrelPlacement = 1
	EventBus.emit_signal("close_build_menu")
	visible = true

#this function locks the child sprite to the mouse position
func _physics_process(delta):
	if mudHutPlacement == 1:
		self.add_child(mudHutMouse)
		var mouse_pos = get_global_mouse_position().snapped(GRID_SIZE)
		tile = world_to_map(mouse_pos)
		mudHutMouse.position = map_to_world(tile)
		
	if largeWallPlacement == 1:
		self.add_child(largeWallMouse)
		var mouse_pos = get_global_mouse_position().snapped(GRID_SIZE)
		tile = world_to_map(mouse_pos)
		largeWallMouse.position = map_to_world(tile)
		
	if smallWallPlacement == 1:
		self.add_child(smallWallMouse)
		var mouse_pos = get_global_mouse_position().snapped(GRID_SIZE)
		tile = world_to_map(mouse_pos)
		smallWallMouse.position = map_to_world(tile)
		
	if torchPlacement == 1:
		self.add_child(torchMouse)
		var mouse_pos = get_global_mouse_position().snapped(GRID_SIZE)
		tile = world_to_map(mouse_pos)
		torchMouse.position = map_to_world(tile)
		
	if bombBarrelPlacement == 1:
		self.add_child(bombBarrelMouse)
		var mouse_pos = get_global_mouse_position().snapped(GRID_SIZE)
		tile = world_to_map(mouse_pos)
		bombBarrelMouse.position = map_to_world(tile)	
	
#The below function places one instance of the mud hut wherever user clicks
func _input(event):
	if mudHutPlacement == 1:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			var buildings = Util.get_main_node().get_node("YSort").get_node("Buildings")
			var mh = mudHut.instance()
			buildings.add_child(mh)
			mh.global_position = get_global_mouse_position().snapped(GRID_SIZE)
			remove_child(mudHutMouse)
			mudHutPlacement = 0
			visible = false
			print("mudhut placed")
			EventBus.emit_signal("unpause_game")
			
	if largeWallPlacement == 1:		
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			var buildings = Util.get_main_node().get_node("YSort/Buildings")
			var lw = largeWall.instance()
			buildings.add_child(lw)
			lw.global_position = get_global_mouse_position().snapped(GRID_SIZE)
			remove_child(largeWallMouse)
			largeWallPlacement = 0
			visible = false
			print("large wall placed")
			EventBus.emit_signal("unpause_game")
			
	if smallWallPlacement == 1:		
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			var buildings = Util.get_main_node().get_node("YSort/Buildings")
			var sw = smallWall.instance()
			buildings.add_child(sw)
			sw.global_position = get_global_mouse_position().snapped(GRID_SIZE)
			remove_child(smallWallMouse)
			smallWallPlacement = 0
			visible = false
			print("small wall placed")
			EventBus.emit_signal("unpause_game")
			
	if torchPlacement == 1:		
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			var buildings = Util.get_main_node().get_node("YSort/Buildings")
			var tp = torch.instance()
			buildings.add_child(tp)
			tp.global_position = get_global_mouse_position().snapped(GRID_SIZE)
			remove_child(torchMouse)
			torchPlacement = 0
			visible = false
			print("torch placed")
			EventBus.emit_signal("unpause_game")
			
	if bombBarrelPlacement == 1:		
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			var buildings = Util.get_main_node().get_node("YSort/Buildings")
			var bb = bombBarrel.instance()
			buildings.add_child(bb)
			bb.global_position = get_global_mouse_position().snapped(GRID_SIZE)
			remove_child(torchMouse)
			bombBarrelPlacement = 0
			visible = false
			print("bomb barrel placed")
			EventBus.emit_signal("unpause_game")
