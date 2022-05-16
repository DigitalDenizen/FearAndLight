extends KinematicBody2D

signal health_updated(health)
signal melee(melee, player_pos, vampireSpider_pos)
signal shoot(shoot, player_pos, vampireSpider_pos)
signal killed()

export (float) var max_health = 350
export (bool) var should_draw_path_line := false

const MOVE_SPEED = 28
enum STATES { IDLE, FOLLOW }
onready var collision_shape = $CollisionShape2D
onready var health = max_health setget _set_health
onready var itemDrop_scene = preload("res://Characters/ItemDrops/SpiderDrop.tscn")
onready var path_line = $PathLine
var Melee = preload("res://Characters/Combat/Melee.tscn")
var Web = preload("res://Characters/Combat/SpiderWeb.tscn")

var player = null
var mudwall = null
var pathFinding: PathFinding
var spawner = {}
var waveSpawn = false
var path = []
var _state = null
var buildings = null
var can_fire = true
var fire_direction
var proejctile_speed
var alive = true
var not_attacking = true
var attackCountDown = 0
var deathCountdown = 0
var launch = 1
var is_recovering = false
var recovery_counter = 0
var velocity: = Vector2.ZERO
var rng = RandomNumberGenerator.new()

var target_point_world = Vector2()
var target_position = Vector2()

func _ready():
	player = Util.get_main_node().get_node("YSort/Player")
	buildings = Util.get_main_node().get_node("YSort/Buildings")
	add_to_group("Baddies")
	rng.randomize()
	path_line.visible = should_draw_path_line

func _physics_process(delta):
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
		var spiderboidVector
		if path.size() > 6 && path.size() < 9:
			onVampireSpiderShoot(Web, player.global_position, global_position)
		elif path.size() > 1.97:
			spiderboidVector = global_position.direction_to(path[1]) * MOVE_SPEED
			walk_animation(spiderboidVector)
			move_and_slide(spiderboidVector)
			set_path_line(path)
		elif path.size() < 1.96:
			onVampireSpiderMelee(Melee, player.global_position, global_position)
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
 
func walk_animation(vector: Vector2):
	if vector.x > 0:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false

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

func move_to(world_position):
	var MASS = 10.0
	var ARRIVE_DISTANCE = 10.0

	var desired_velocity = (world_position - position).normalized() * MOVE_SPEED
	var steering = desired_velocity - velocity
	velocity += steering / MASS
	position += velocity * get_process_delta_time()
	rotation = velocity.angle()
	return position.distance_to(world_position) < ARRIVE_DISTANCE

func hurt(damage):
	var vec_not_norm = player.global_position - global_position
	var vec_to_player = vec_not_norm.normalized()
	move_and_collide(vec_to_player * -10)
	_set_health(health - damage)

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health <= 0:
			deathCountdown = 15
			alive = false
			$AnimatedSprite.play("death")

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

func onVampireSpiderMelee(melee, playerPos, vampireSpiderPos):
	not_attacking = false
	var player_direction = playerPos - vampireSpiderPos
	if player_direction.x > 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("melee")
	else:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("melee")
	attackCountDown = 50
	var scratch = Melee.instance()
	scratch.attacker = "vampireSpider"
	add_child(scratch)
	scratch.shoot(playerPos, vampireSpiderPos)

func _on_vampireSpider_killed():
	if rng.randf() <= 1:
		var itemDrop = itemDrop_scene.instance()
		itemDrop.type = rng.randi() % 2
		get_tree().get_root().add_child(itemDrop)
		itemDrop.global_position = global_position

func onVampireSpiderShoot(shoot, playerPos, vampireSpiderPos):
	not_attacking = false
	var player_direction = playerPos - vampireSpiderPos
	if player_direction.x > 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("projectile")
	else:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("projectile")
	attackCountDown = 50
	var web = shoot.instance()
	add_child(web)
	web.shoot(playerPos, vampireSpiderPos)

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
