extends KinematicBody2D
signal health_updated(health)
signal melee(Melee, player_pos, vampireSpider_pos)
signal shoot(Web, player_pos, vampireSpider_pos)
signal killed()

export (bool) var should_draw_path_line := false
export (float) var max_health = 150

const MOVE_SPEED = 28
onready var itemdrop_scene = load("res://Characters/Item_Drops/Item_Drop_2.tscn")
onready var health = max_health setget _set_health
onready var path_line = $Pathline
var Melee = preload("res://Characters/Combat/Melee.tscn")
var Web = preload("res://Characters/Combat/sprider_web.tscn")
var player = null
var mudwall = null

var pathFinding: PathFinding
var spawner = {}
var waveSpawn = false
var buildings = null
var path = []
var _state = null
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
	player = Util.get_main_node().get_node("Player")
	buildings = Util.get_main_node().get_node("Buildings")
	player = get_parent().get_node("Player")
	rng.randomize()
	path_line.visible = should_draw_path_line

func _physics_process(delta):
	if player == null:
		return
	if mudwall == null:
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
		
		var vampireSpiderVector
		if path.size() > 2:
			vampireSpiderVector = global_position.direction_to(path[1]) * MOVE_SPEED
			walk_animation(vampireSpiderVector)
			move_and_slide(vampireSpiderVector)
			set_path_line(path)
		else:
			_on_VampireSpider_shoot(Melee, player.global_position, global_position)
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

func set_player(p):
	player = p

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
			Score.onVampireSpiderKilled()
			alive = false
			$AnimatedSprite.play("death")

func _on_VampireSpider_melee(Melee, player_pos, vampireSpider_pos):
	not_attacking = false
	var player_direction = player_pos - vampireSpider_pos
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
	scratch.shoot(player_pos, vampireSpider_pos)
	
func _on_VampireSpider_shoot(Web, player_pos, vampireSpider_pos):
	not_attacking = false
	var player_direction = player_pos - vampireSpider_pos
	if player_direction.x > 0:
		$AnimatedSprite.play("projectile")
		$AnimatedSprite.flip_h = true
	else: 
		$AnimatedSprite.play("projectile")
		$AnimatedSprite.flip_h = false
	attackCountDown = 175
	var web = Web.instance()
	add_child(web)
	web.shoot(player_pos, vampireSpider_pos)

func _on_vampireSpider_killed():
	if rng.randf() <= 0.8:
		var itemDrop = itemdrop_scene.instance()
		itemDrop.type = rng.randi() % 2
		get_tree().get_root().add_child(itemDrop)
		itemDrop.global_position = global_position

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
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true

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
