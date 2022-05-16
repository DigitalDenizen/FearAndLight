extends Area2D

onready var emptyCursor = preload("res://Images/UI/Cursors/ui-cursor-empty.png")
onready var enemyIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-enemy.png")
onready var defenseIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-defense.png")
onready var objectIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-object.png")
onready var tilemapIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-tilemap.png")
onready var structureIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-structures.png")
onready var mushroomIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-mushrooms.png")
onready var Icon = self.get_node("Sprite")

func _ready():
	Icon.hide()
	
func _process(delta):
	self.position = self.get_global_mouse_position()

func _on_Cursor_body_entered(body):
	if body.is_in_group("Objects"):
		Icon.show()
		self.Icon.texture = objectIcon
	if body.is_in_group("Baddies"):
		Icon.show()
		self.Icon.texture = enemyIcon
	if body.is_in_group("Structures"):
		Icon.show()
		self.Icon.texture = structureIcon
	if body.is_in_group("TileMaps"):
		Icon.show()
		self.Icon.texture = tilemapIcon
	if body.is_in_group("Defenses"):
		Icon.show()
		self.Icon.texture = defenseIcon
	if body.is_in_group("Mushrooms"):
		Icon.show()
		self.Icon.texture = mushroomIcon

func _on_Cursor_body_exited(body):
	if body.is_in_group("Objects") || body.is_in_group("Baddies") || body.is_in_group("Structures") || body.is_in_group("TileMaps") || body.is_in_group("UI") || body.is_in_group("Defenses") || body.is_in_group("Mushrooms"):
		Icon.hide()
