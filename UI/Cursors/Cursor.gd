extends Area2D

export(Texture) var empty_cursor = null
export(Texture) var arrow_cursor = null
export(Texture) var target_cursor = null
export(Texture) var pointer_cursor = null
export(Texture) var sword_cursor = null
export(Texture) var ibeam_cursor = null
export(Texture) var hand_open_cursor = null
export(Texture) var hand_grab_cursor = null

export(Vector2) var base_window_size = Vector2.ZERO
export(Vector2) var base_cursor_size = Vector2.ZERO

onready var emptyCursor = preload("res://Images/UI/Cursors/ui-cursor-empty.png")
onready var enemyIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-enemy.png")
onready var defenseIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-defense.png")
onready var objectIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-object.png")
onready var tilemapIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-tilemap.png")
onready var structureIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-structures.png")
onready var mushroomIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-mushrooms.png")
onready var doorIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-door.png")
onready var heartIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-heart.png")
onready var bossIcon = preload("res://Images/UI/Cursors/ui-cursor-icon-boss.png")
onready var Icon = self.get_node("Sprite")

func _ready():
	update_cursor()
	get_tree().connect("screen_resized", self, "update_cursor")
	Icon.hide()
	
func _physics_process(delta):
	self.position = self.get_global_mouse_position()
	
func update_cursor():
	var current_window_size = OS.window_size
	var scale_multiple = min(floor(current_window_size.x / base_window_size.x), floor(current_window_size.y / base_window_size.y))
	
	# Get Images
	var texture_arrow = ImageTexture.new()
	var texture_pointer = ImageTexture.new()
	var texture_ibeam = ImageTexture.new()
	var texture_sword = ImageTexture.new()
	var texture_hand_open = ImageTexture.new()
	
	# Get Texture Data
	var arrow = arrow_cursor.get_data()
	var pointer = pointer_cursor.get_data()
	var ibeam = ibeam_cursor.get_data()
	var sword = sword_cursor.get_data()
	var hand_open = hand_open_cursor.get_data()
	
	# Interpolate
	arrow.resize(base_cursor_size.x * (scale_multiple), base_cursor_size.y * (scale_multiple ), Image.INTERPOLATE_NEAREST)
	pointer.resize(base_cursor_size.x * (scale_multiple), base_cursor_size.y * (scale_multiple), Image.INTERPOLATE_NEAREST)
	ibeam.resize(base_cursor_size.x * (scale_multiple), base_cursor_size.y * (scale_multiple), Image.INTERPOLATE_NEAREST)
	sword.resize(base_cursor_size.x * (scale_multiple), base_cursor_size.y * (scale_multiple), Image.INTERPOLATE_NEAREST)
	hand_open.resize(base_cursor_size.x * (scale_multiple), base_cursor_size.y * (scale_multiple), Image.INTERPOLATE_NEAREST)
	
	# Create New Texture
	texture_arrow.create_from_image(arrow)
	texture_pointer.create_from_image(pointer)
	texture_ibeam.create_from_image(ibeam)
	texture_sword.create_from_image(sword)
	texture_hand_open.create_from_image(hand_open)
	
	# Set Custom Cursor
	Input.set_custom_mouse_cursor(texture_arrow, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(texture_pointer, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(texture_ibeam, Input.CURSOR_IBEAM)
	Input.set_custom_mouse_cursor(texture_sword, Input.CURSOR_CROSS)
	Input.set_custom_mouse_cursor(texture_hand_open, Input.CURSOR_DRAG)

func arrow_cursor():
	var current_window_size = OS.window_size
	var scale_multiple = min(floor(current_window_size.x / base_window_size.x), floor(current_window_size.y / base_window_size.y))
	var texture_arrow = ImageTexture.new()
	var arrow = arrow_cursor.get_data()
	arrow.resize(base_cursor_size.x * (scale_multiple), base_cursor_size.y * (scale_multiple), Image.INTERPOLATE_NEAREST)
	texture_arrow.create_from_image(arrow)
	return texture_arrow
	
func pointer_cursor():
	var current_window_size = OS.window_size
	var scale_multiple = min(floor(current_window_size.x / base_window_size.x), floor(current_window_size.y / base_window_size.y))
	var texture_pointer = ImageTexture.new()
	var pointer = pointer_cursor.get_data()
	pointer.resize(base_cursor_size.x * (scale_multiple), base_cursor_size.y * (scale_multiple), Image.INTERPOLATE_NEAREST)
	texture_pointer.create_from_image(pointer)
	return texture_pointer
	
func target_cursor():
	var current_window_size = OS.window_size
	var scale_multiple = min(floor(current_window_size.x / base_window_size.x), floor(current_window_size.y / base_window_size.y))
	var texture_target = ImageTexture.new()
	var target = target_cursor.get_data()
	target.resize(base_cursor_size.x * (scale_multiple), base_cursor_size.y * (scale_multiple), Image.INTERPOLATE_NEAREST)
	texture_target.create_from_image(target)
	return texture_target

func _on_Cursor_body_entered(body):
	var texture_target = target_cursor()
	var texture_pointer = pointer_cursor()
	
	# Set Custom Hovers
	if body.is_in_group("Objects"):
		Icon.show()
		self.Icon.texture = objectIcon
		Input.set_custom_mouse_cursor(texture_target, Input.CURSOR_ARROW, Vector2(30, 30))
#		      set_custom_mouse_cursor(Resource image, CursorShape shape=0, Vector2 hotspot=Vector2( 0, 0 ) )
	if body.is_in_group("Baddies"):
		Icon.show()
		self.Icon.texture = enemyIcon
		Input.set_custom_mouse_cursor(texture_target, Input.CURSOR_ARROW, Vector2(30, 30))
	if body.is_in_group("Structures"):
		Icon.show()
		self.Icon.texture = structureIcon
		Input.set_custom_mouse_cursor(texture_pointer, Input.CURSOR_ARROW)
	if body.is_in_group("Doors"):
		Icon.show()
		self.Icon.texture = doorIcon
		Input.set_custom_mouse_cursor(texture_pointer, Input.CURSOR_ARROW)
	if body.is_in_group("Defenses"):
		Icon.show()
		self.Icon.texture = defenseIcon
		Input.set_custom_mouse_cursor(texture_pointer, Input.CURSOR_ARROW)
	if body.is_in_group("Mushrooms"):
		Icon.show()
		self.Icon.texture = mushroomIcon
		Input.set_custom_mouse_cursor(texture_target, Input.CURSOR_ARROW, Vector2(30, 30))
	if body.is_in_group("Bosses"):
		Icon.show()
		self.Icon.texture = bossIcon
		Input.set_custom_mouse_cursor(texture_target, Input.CURSOR_ARROW, Vector2(30, 30))

func _on_Cursor_body_exited(body):
	var texture_arrow = arrow_cursor()
	
	# Set Custom Hovers
	if body.is_in_group("Player") || body.is_in_group("Objects") || body.is_in_group("Baddies") || body.is_in_group("Structures") || body.is_in_group("TileMaps") || body.is_in_group("UI") || body.is_in_group("Defenses") || body.is_in_group("Mushrooms") || body.is_in_group("Bosses"):
		Icon.hide()
		Input.set_custom_mouse_cursor(texture_arrow, Input.CURSOR_ARROW)
