class_name Item

var itemName setget setName, getName
var quant setget setQuant, getQuant

func _init(name, quant):
	itemName = name
	quant = quant

func setName(name):
	itemName = name

func getName():
	return itemName

func setQuant(quant):
	quant = quant

func getQuant():
	return quant
