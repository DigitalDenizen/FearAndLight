extends KinematicBody2D
class_name Wendigo

signal health_updated(health)
signal melee(melee, player_pos, wendigo_pos)
signal killed()

export (float) var max_health = 100
export (bool) var should_draw_path_line := false

const MOVE_SPEED = 40
enum STATES { IDLE, FOLLOW }
onready var collision_shape = $CollisionShape2D
onready var health = max_health setget _set_health
onready var path_line = $PathLine
onready var itemDropScene = load("res://Characters/ItemDrops/WendigoItemDrop.tscn")
var Melee = preload("res://Characters/Combat/Melee.tscn")

var pathFinding: PathFinding
var spawner = {}
var waveSpawn = false
var player = null
var path = []
var _state = null
var buildings = null
var alive = true
var not_attacking = true
var attackCountDown = 0
var deathCountdown = 0
var velocity: = Vector2.ZERO
var rng = RandomNumberGenerator.new()

var target_point_world = Vector2()
var target_position = Vector2()

func _ready():
	player = Util.get_main_node().get_node("Player")
	buildings = Util.get_main_node().get_node("Buildings")
	add_to_group("Baddies")
	rng.randomize()
	path_line.visible = should_draw_path_line

func _process(delta):
	if player == null:  
		return
	if alive && not_attacking:
		var pathHeroes:PoolVector2Array = pathFinding.get_new_path(global_position, player.global_position)
		var buildingList = buildings.get_children()
		if buildingList.size() > 0:
			var pathBuildings:PoolVector2Array = prioritize_target(buildings)
			
			if pathHeroes.size() < 10:
				path = pathHeroes
			elif pathBuildings.size() < 5:
				path = pathBuildings
			else:
				path = pathHeroes
		else:
			path = pathHeroes
		
		var wendigodVector
		if path.size() > 2:
			wendigodVector = global_position.direction_to(path[1]) * MOVE_SPEED
			walk_animation(wendigodVector)
			move_and_slide(wendigodVector)
			set_path_line(path)
		else:
			_on_Wendigo_melee(Melee, player.global_position, global_position)
	else:
		if not_attacking:
			deathCountdown = deathCountdown - 1
			if deathCountdown == 0:
				kill()
				emit_signal("killed")
		else:
			attackCountDown = attackCountDown - 1
			if attackCountDown == 0:
				not_attacking = true

func kill():
	queue_free()

func _change_state(new_state):
	if new_state == STATES.FOLLOW:
		path = get_parent().get_node('TileMap').find_path(position, player.global_position)
		if not path or len(path) == 1:
			_change_state(STATES.IDLE)
			return
		# The index 0 is the starting cell
		# we don't want the character to move back to it in this example
		target_point_world = path[1]
	_state = new_state
	
func set_player(p):
	player = p

func on_wendigo_killed():
		if rng.randf() <= 0.3:
			var itemDrop = itemDropScene.instance()

func _on_Wendigo_melee(Melee, target_pos, wendigo_pos):
	var direction = target_pos - wendigo_pos
	if direction.x > 2:
		$AnimatedSprite.play("attack - slash")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("attack - slash")
		$AnimatedSprite.flip_h = false
		
func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health <= 0:
			Score._on_Zombie_killed()
			if waveSpawn:
				spawner.removeEnemy()
			alive = false
			deathCountdown = 30

func set_path_line(points: Array):
	if not should_draw_path_line:
		return
		
	var local_points := []
	for point in points:
		if point == points[0]:
			local_points.append(Vector2.ZERO)
		else:
			local_points.append(point - global_position)

	path_line.points = local_points

func walk_animation(vector: Vector2):
	if vector.x > 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false

func prioritize_target(buildings):
	var target:PoolVector2Array
	var count = 0
	for building in buildings.get_children():
		var currentPath:PoolVector2Array = pathFinding.get_new_path(global_position, building.global_position)
		if currentPath.size() > 0:
			if count == 0:
				target = currentPath
			
			target = currentPath if currentPath.size() < target.size() else target
		
	return target
