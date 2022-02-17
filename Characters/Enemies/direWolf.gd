extends KinematicBody2D

signal health_updated(health)
signal melee(melee, player_pos, direWolf_pos)
signal killed()

export (float) var max_health = 100
export (bool) var should_draw_path_line := false

const MOVE_SPEED = 40
enum STATES { IDLE, FOLLOW }
onready var collision_shape = $CollisionShape2D
onready var health = max_health setget _set_health
onready var itemDrop_scene = preload("res://Characters/ItemDrops/wolfDrop.tscn")
onready var path_line = $PathLine
var Melee = preload("res://Characters/Combat/Melee.tscn")

var pathFinding: PathFinding
var spawner = {}
var waveSpawn = false
var player = null
var pathObject
var _state = null
var target = false
var buildings = null
var alive = true
var pathBuildings
var previousPosition
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
	
func _physics_process(delta):
	if player == null:
		return
	if alive && not_attacking:
		var target = true
		var targetList = buildings.get_children()
		targetList.append(player)
		var targetObject = prioritize_target(targetList)
		if targetObject.path.size() > 30:
			var noTarget = TargetPath.new()
			targetObject = noTarget
			target = false
			
		var enemyVector
		if targetObject.path.size() > 2:
			enemyVector = global_position.direction_to(targetObject.path[1]) * MOVE_SPEED
			walk_animation(enemyVector)
			move_and_slide(enemyVector)
			set_path_line(targetObject.path)
		elif targetObject.path.size() == 0 && !target:
			_change_state(STATES.IDLE)
		else:
			_on_direWolf_melee(Melee, targetObject.targetObject.global_position, global_position)
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
		pathObject.path = get_parent().get_node("TileMap").find_path(position, player.global_position)
		if not pathObject.path or len(pathObject.path) == 1:
			_change_state(STATES.IDLE)
			return
		# The index 0 is the starting cell
		# we don't want the character to move back to it in this example
		target_point_world = pathObject.path[1]
	_state = new_state

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
			Score._on_Zombie_killed()
			if waveSpawn:
				spawner.removeEnemy()
			alive = false
			deathCountdown = 30
			$AnimatedSprite.play("Death")

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
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = false

func prioritize_target(targets):
	var target
	var distanceToCompare
	var firstItem = true
	for obj in targets:
		if firstItem:
			firstItem = false
			distanceToCompare = obj.global_position.distance_to(global_position);
			target = obj
			
		if distanceToCompare > obj.global_position.distance_to(global_position):
			distanceToCompare = obj.global_position.distance_to(global_position);
			target = obj
		
	var closestTarget = TargetPath.new()
	closestTarget.targetObject = target
	closestTarget.path = pathFinding.get_new_path(global_position, target.global_position)
	return closestTarget

func _on_direWolf_melee(melee, target_pos, direWolf_pos):
	var direction = target_pos - direWolf_pos
	if direction.x > 0:
		$AnimatedSprite.play("Attack")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("Attack")
		$AnimatedSprite.flip_h = false
	not_attacking = false
	attackCountDown = 50
	var scratch = Melee.instance()
	scratch.attacker = "direWolf"
	add_child(scratch)
	scratch.shoot(target_pos, direWolf_pos)
	$RandomBarkPlayer.play_random()

func _on_direWolf_killed():
	if rng.randf() <= 0.8:
		var itemDrop = itemDrop_scene.instance()
		get_tree().get_root().add_child(itemDrop)
		itemDrop.global_position = global_position
