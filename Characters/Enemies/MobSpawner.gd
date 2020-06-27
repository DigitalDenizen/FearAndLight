extends Node 

export (float) var shape_x = 0.0
export (float) var shape_y = 0.0
export (int) var spawn_num = 0

func _ready():
	var colShape = $Spawn_area
	if shape_x != 0.0 && shape_y != 0.0:
		colShape.shape.extents = Vector2(shape_x/2, shape_y/2)
		
	var rand = RandomNumberGenerator.new()
	var center = colShape.position
	var size = colShape.shape.extents
	var enemyscene = load("res://Characters/Zombie.tscn")
	var screen_size = get_viewport().get_visible_rect().size
	for i in range(0,spawn_num):
		var enemy = enemyscene.instance()
		enemy.add_to_group('Baddies')
		enemy.position.y = (randi() % int(size.x)) - (int(size.x/2)) + center.x
		enemy.position.x = (randi() % int(size.y)) - (int(size.y/2)) + center.y
		add_child(enemy)
