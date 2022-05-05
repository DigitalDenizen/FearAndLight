extends WindowDialog

const SlotClass = preload("res://UI/Inventory/Slot.gd")
var Item = preload("res://Shared/Models/Item.tscn")
onready var inventorySlots = $TabContainer/ITEMS/MarginContainer/GridContainer/
var holdingItem = null

func _ready() -> void:
	EventBus.connect("toggle_inventory", self, "_on_Button_toggled")
	visible = false
	for slot in inventorySlots.get_children():
		slot.connect("guiInput", self, "slotGuiInput", [slot])

func slotGuiInput(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holdingItem != null:
				if !slot.item:
					slot.putInputSlot(holdingItem)
					holdingItem
				else:
					var tempItem = slot.item
					slot.pickFromSlot()
					tempItem.global_position = event.global_position
					slot.putIntoSlot(tempItem)
					holdingItem = tempItem
			elif slot.item:
				holdingItem = slot.item
				slot.pickFromSlot()
				holdingItem.global_position = get_global_mouse_position()

func _input(event):
	if holdingItem:
		holdingItem.global_position = get_global_mouse_position()

func addPickedUpItem(itemName, filePath, category):
	var added = false
	for slot in inventorySlots.get_children():
		if !slot.item:
			if !added:
				added = true
				slot.initialize_item(itemName, filePath, category)
		else:
			if slot.item.itemName == itemName && !slot.item.stackFull && !added:
				added = true
				slot.initialize_item(itemName, filePath, category)

func _on_Button_toggled(button_pressed: bool) -> void:
	if !visible:
		visible = true
		get_tree().paused = true
	else:
		visible = false
		get_tree().paused = false
