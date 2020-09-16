extends KinematicBody2D
signal health_updated(health)
signal melee(Melee, player_pos, vampireSpider_pos)
signal shoot(Web, player_pos, vampireSpider_pos)
signal killed()

const MOVE_SPEED = 65
export (float) var max_health = 100
onready var itemdrop_scene = preload("res://Characters/Item_Drops/Item_Drop_2.tscn")
onready var health = max_health setget _set_health
var Melee = preload("res://Characters/Combat/Melee.tscn")
var Web = preload("res://Characters/Combat/sprider_web.tscn")
var player = null
var mudwall = null

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

func _ready():
	$AnimatedSprite.play("idle")
	player = get_parent().get_node("Player")
	mudwall = get_parent().get_node("MudWall")
	rng.randomize()

func _physics_process(delta):
	if player == null:
		return
	if mudwall == null:
		return
	if alive && not_attacking:
		var vec_not_norm = player.global_position - global_position
		var vec_to_player = vec_not_norm.normalized()
		var collison = move_and_collide(vec_to_player * MOVE_SPEED * delta)
		
		velocity = Movement_Logic._follow(velocity, global_position, player.global_position, MOVE_SPEED)
		move_and_slide(velocity)
		if vec_not_norm.x > 0:
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("walk")
		
		if abs(vec_not_norm.x) <= 65 && abs(vec_not_norm.y) <= 65: 
			_on_vampireSpider_melee(Melee, player.global_position, global_position)
	
		elif abs(vec_not_norm.x) > 65 && abs(vec_not_norm.y) > 65:
			_on_vampireSpider_shoot(Web, player.global_position, global_position)
		
		var _look_vec = get_global_mouse_position() - global_position
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
			deathCountdown = 20
			Score._on_vampire_spider_killed()
			alive = false
			$AnimatedSprite.play("death")
			

func _on_vampireSpider_melee(Melee, player_pos, vampireSpider_pos):
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

func _on_vampireSpider_killed():
	if rng.randf() <= 0.8:
		var itemDrop = itemdrop_scene.instance()
		itemDrop.type = rng.randi() % 2
		get_tree().get_root().add_child(itemDrop)
		itemDrop.global_position = global_position

func _on_vampireSpider_shoot(Web, player_pos, vampireSpider_pos):
	not_attacking = false
	var player_direction = player_pos - vampireSpider_pos
	if player_direction.x > 0:
		$AnimatedSprite.play("projectile")
		$AnimatedSprite.flip_h = true
	else: 
		$AnimatedSprite.play("projectile")
		$AnimatedSprite.flip_h = false
	attackCountDown = 50
	var web = Web.instance()
	add_child(web)
	web.shoot(player_pos, vampireSpider_pos)
