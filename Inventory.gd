extends HBoxContainer

var inventory = self.get_children()

func addItem(itemToAdd):
	addToInventory(itemToAdd)


func addToInventory(itemToAdd):
	var itemAdded = false
	var count = 0
	for item in inventory:
		count += 1
		if item.name == itemToAdd:
			item.quant += 1
			itemAdded = true

	if !itemAdded:
		var newItem = Item.new(itemToAdd, 1)
		inventory.append(newItem)


func updateInventoryBar(space, item: Item):
	var uiItem: Button = inventory[space]
	uiItem.text = item.quant
	uiItem.icon = item.itemName
	
