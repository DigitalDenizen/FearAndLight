extends Panel

var default_tex = preload("res://Images/UI/Chest/ui-chest-bkgd-drop-slot.png")
var default_style: StyleBoxTexture = null

var ItemClass = preload("res://Shared/Models/Item.tscn")
var item = null
var slotIndex

enum SlotType {
	HOTBAR = 0,
	INVENTORY,
	SHIRT,
	PANTS,
	SHOES,
}

var slotType = null

func _ready():
	default_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	
	refresh_style()
		
func refresh_style():
	set('custom_styles/panel', default_style)

func pickFromSlot():
	remove_child(item)
	find_parent("Overlay").add_child(item)
	item = null
	refresh_style()
	
func putIntoSlot(newItem):
	item = newItem
	find_parent("Overlay").remove_child(item)
	add_child(item)
	refresh_style()
	
func initialize_item(itemName, filePath, category):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
		item.setName(itemName)
		item.setCategory(category)
		item.setImage(filePath)
		item.setStackNumber(1)
	else:
		print(item.getStackNumber())
		item.setStackNumber(item.getStackNumber() + 1)
	refresh_style()
