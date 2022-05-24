extends Node2D

onready var emptyCursor = preload("res://Images/UI/Cursors/ui-cursor-empty.png")
onready var arrowCursor = preload("res://Images/UI/Cursors/ui-cursor-arrow.png")
onready var pointerCursor = preload("res://Images/UI/Cursors/ui-cursor-pointer.png")
onready var targetCursor = preload("res://Images/UI/Cursors/ui-cursor-target.png")
onready var swordCursor = preload("res://Images/UI/Cursors/ui-cursor-sword.png")
onready var hammerCursor = preload("res://Images/UI/Cursors/ui-cursor-hammer.png")
#onready var rockCursor = preload("res://Images/UI/Cursor/ui-cursor-rock.png")
#onready var Icon = self.get_node("Sprite")
#var cursor = null


func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_custom_mouse_cursor(arrowCursor)
#	cursor = Util.get_main_node().get_node("YSort/Player/")
