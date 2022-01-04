extends Node2D

var itemName
var stackLimit
var category
var imagePath = ""
var stackFull = false

onready var stackNumber = $Label
onready var stackImage = $TextureRect

func setName(name):
	itemName = name

func getName():
	return itemName

func setStack(category):
	var itemType = Constants.itemCategories
	var num = 1
	match category:
		itemType.CONSUMABLE:
			num = 99
		itemType.MATERIAL:
			num = 30
		itemType.TOOL:
			num = 1
		itemType.WEAPON:
			num = 1
			
	stackLimit = num

func getStack():
	return stackLimit
	
func setStackNumber(num):
	stackNumber.text = str(num)
	if num == stackLimit:
		stackFull = true
	
func getStackNumber():
	return int(stackNumber.text)

func setCategory(category):
	category = category
	setStack(category)

func getCategory():
	return category
	
func setImage(filePath):
	stackImage.texture = load(filePath)
	imagePath = filePath
	
