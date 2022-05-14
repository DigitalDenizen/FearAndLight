extends Node2D

onready var emptyCursor = preload("res://Images/UI/Cursors/ui-cursor-empty.png")
onready var arrowCursor = preload("res://Images/UI/Cursors/ui-cursor-arrow.png")
onready var pointerCursor = preload("res://Images/UI/Cursors/ui-cursor-pointer.png")
onready var targetCursor = preload("res://Images/UI/Cursors/ui-cursor-target.png")
onready var swordCursor = preload("res://Images/UI/Cursors/ui-cursor-sword.png")
onready var hammerCursor = preload("res://Images/UI/Cursors/ui-cursor-hammer.png")
onready var Icon = self.get_node("Sprite")
var cursor

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _process(delta):
	self.position = self.get_global_mouse_position()
	
#	Potential usage
#	Input.set_custom_mouse_cursor(pointerCursor, Input.CURSOR_POINTING_HAND, Vector2())

func _on_Cursor_body_entered(body):
	var cursor = Util.get_main_node().get_node("YSort/Player/Camera2D/Overlay/GridContainer/Cursor")
	if body.is_in_group("Objects"):
		self.Icon.texture = targetCursor
		cursor.visible = false
	if body.is_in_group("Baddies"):
		self.Icon.texture = swordCursor
		cursor.visible = false
	if body.is_in_group("Structures"):
		self.Icon.texture = hammerCursor
		cursor.visible = false

func _on_Cursor_body_exited(body):
	var cursor = Util.get_main_node().get_node("YSort/Player/Camera2D/Overlay/GridContainer/Cursor")
	if body.is_in_group("Objects") || body.is_in_group("Baddies") || body.is_in_group("Structures"):
		self.Icon.texture = arrowCursor
		cursor.visible = true
