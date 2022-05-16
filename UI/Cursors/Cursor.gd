extends Area2D

onready var emptyCursor = preload("res://Images/UI/Cursors/ui-cursor-empty.png")
onready var arrowCursor = preload("res://Images/UI/Cursors/ui-cursor-arrow.png")
onready var pointerCursor = preload("res://Images/UI/Cursors/ui-cursor-pointer.png")
onready var targetCursor = preload("res://Images/UI/Cursors/ui-cursor-target.png")
onready var swordCursor = preload("res://Images/UI/Cursors/ui-cursor-sword.png")
onready var hammerCursor = preload("res://Images/UI/Cursors/ui-cursor-hammer.png")
onready var rockCursor = preload("res://Images/UI/Cursors/ui-cursor-rock.png")
onready var Icon = self.get_node("Sprite")

func _ready():
	Icon.hide()
	
func _process(delta):
	self.position = self.get_global_mouse_position()

func _on_Cursor_body_entered(body):
	if body.is_in_group("Objects"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		self.Icon.texture = swordCursor
		Icon.show()
	if body.is_in_group("Baddies"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		self.Icon.texture = swordCursor
		Icon.show()
	if body.is_in_group("Structures"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		self.Icon.texture = hammerCursor
		Icon.show()
	if body.is_in_group("TileMaps"):
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		self.Icon.texture = rockCursor
		Icon.show()

func _on_Cursor_body_exited(body):
	if body.is_in_group("Objects") || body.is_in_group("Baddies") || body.is_in_group("Structures") || body.is_in_group("TileMaps"):
		Icon.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
