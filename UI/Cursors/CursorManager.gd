extends CanvasLayer

export(Texture) var empty_cursor = null
export(Texture) var arrow_cursor = null
export(Texture) var target_cursor = null
export(Texture) var pointer_cursor = null
export(Texture) var sword_cursor = null

export(Vector2) var base_window_size = Vector2.ZERO
export(Vector2) var base_cursor_size = Vector2.ZERO

onready var Icon = self.get_node("Cursor/Sprite")

func _ready():
	Icon.hide()
	update_cursor()
	get_tree().connect("screen_resized", self, "update_cursor")

func _process(delta):
	Icon.position = Icon.get_global_mouse_position()

func update_cursor():
	var current_window_size = OS.window_size
	var scale_multiple = min(floor(current_window_size.x / base_window_size.x), floor(current_window_size.y / base_window_size.y))
	
	# Get Images
	var texture_arrow = ImageTexture.new()
	var texture_pointer = ImageTexture.new()
	
	# Get Texture Data
	var image = arrow_cursor.get_data()
	var pointer = pointer_cursor.get_data()
	
	# Interpolate
	image.resize(base_cursor_size.x * (scale_multiple + 1), base_cursor_size.y * (scale_multiple + 1), Image.INTERPOLATE_NEAREST)
	pointer.resize(base_cursor_size.x * (scale_multiple + 1), base_cursor_size.y * (scale_multiple + 1), Image.INTERPOLATE_NEAREST)
	
	# Create New Texture
	texture_arrow.create_from_image(image)
	texture_pointer.create_from_image(pointer)
	
	Input.set_custom_mouse_cursor(texture_arrow, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(texture_pointer, Input.CURSOR_POINTING_HAND)
