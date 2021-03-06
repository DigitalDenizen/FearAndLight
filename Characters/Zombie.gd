extends KinematicBody2D

signal health_updated(health)
signal melee(melee, player_pos, zombie_pos)
signal killed()

const MOVE_SPEED = 38
export (float) var max_health = 100
onready var health = max_health setget _set_health
onready var itemDrop_scene = preload("res://Characters/Item_Drops/Item_Drop.tscn")
var Melee = preload("res://Characters/Combat/Melee.tscn")

var player = null
var wall = null
var alive = true
var not_attacking = true
var attackCountDown = 0
var deathCountdown = 0
var velocity: = Vector2.ZERO
var rng = RandomNumberGenerator.new()

func _ready():
	player = get_parent().get_parent().get_node("Player")
	add_to_group("Baddies")
	rng.randomize()
	
func _physics_process(delta):
	if player == null:
		return
	if alive && not_attacking:
		var vec_not_norm = player.global_position - global_position
		var vec_to_player = vec_not_norm.normalized()
		var collision = move_and_collide(vec_to_player * MOVE_SPEED * delta)
		
		velocity = Movement_Logic._follow(velocity, global_position, player.global_position, MOVE_SPEED)
		move_and_slide(velocity)
		
		if vec_not_norm.x > 0:
			$AnimatedSprite.play("Walk")
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.play("Walk")
			$AnimatedSprite.flip_h = true
		
		if abs(vec_not_norm.x) < 30 && abs(vec_not_norm.y) < 30:
			_on_Zombie_melee(Melee, player.global_position, global_position)
			
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

func set_player(p):
	player = p

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
			alive = false
			deathCountdown = 30
			$AnimatedSprite.play("Death")

func _on_Zombie_melee(Melee, player_pos, zombie_pos):
	var direction = player_pos - zombie_pos
	if direction.x > 0:
		$AnimatedSprite.play("Attack")
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("Attack")
		$AnimatedSprite.flip_h = true
	not_attacking = false
	attackCountDown = 50
	var scratch = Melee.instance()
	scratch.attacker = "Zombie"
	add_child(scratch)
	scratch.shoot(player_pos, zombie_pos)

func _on_Zombie_killed():
	if rng.randf() <= 0.3:
		var itemDrop = itemDrop_scene.instance()
		itemDrop.type = rng.randi() % 2
		get_tree().get_root().add_child(itemDrop)
		itemDrop.global_position = global_position
