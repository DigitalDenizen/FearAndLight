extends Panel
var ItemClass = preload("res://Structures/MudWall.tscn")
var item  = null


func _ready():
	item = ItemClass.instance()
	
func pickFromSlot():
	remove_child(item)
	var invetoryNode = find_parent("Inventory")
	invetoryNode.add_child(item)
	item = null
	

func putIntoSlot(new_item):
  item = new_item
  item.position = Vector2(0, 0)
  var invetoryNode = find_parent("Inventory")
  invetoryNode.remove_child(item)
  add_child(item)
  
