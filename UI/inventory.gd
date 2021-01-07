extends Node2D

const SlotClass = preload("res://UI/slot.gd")
const GridClass = preload("res://UI/gridpanel.gd")
onready var inventory_slots = $Menu/GridContainer
onready var grid_slots = $Grid/GridContainer2
var holding_item = null

func _on_ButtonBar_config():
	$Grid.visible = true
	$Menu.visible = true

func _ready():
				
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self, "slot_pickup", [inv_slot])
		
	for grid_slot in grid_slots.get_children():
		grid_slot.connect("gui_input", self, "slot_drop", [grid_slot])
		

func slot_pickup(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if slot.item:
				holding_item = slot.item
				slot.pickFromSlot()
				holding_item.global_position = get_global_mouse_position()
				$Grid.visible = true
				$Menu.visible = false
	
		

func slot_drop(event: InputEvent, gridpanel: GridClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item != null:
				holding_item = null
				$Grid.visible = false
				
	
func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()		
