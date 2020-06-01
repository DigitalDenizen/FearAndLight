extends KinematicBody2D

signal health_updated(health)
signal melee(melee, player_pos, zombie_pos)
signal killed()

const MOVE_SPEED = 75
export (float) var max_health = 100
onready var health = max_health setget _set_health
onready var bones_scene = preload("res://Characters/Item Drops/Bones.tscn")

var Melee = preload("res://Characters/Combat/Melee.tscn")

var player = null
var wall = null
var alive = true
var not_attacking = true
var attackCountDown = 0
var deathCountdown = 0
var facing_right = true
var velocity: = Vector2.ZERO
var rng = RandomNumberGenerator.new()


func _ready():
	add_to_group("zombies")
	rng.randomize()
	

func _physics_process(delta):
	if player == null:
		return
	if alive && not_attacking:
		var vec_not_norm = player.global_position - global_position
		var vec_to_player = vec_not_norm.normalized()
		var collision = move_and_collide(vec_to_player * MOVE_SPEED * delta)
		
		velocity = MovementLogic._follow(velocity, global_position, player.global_position, MOVE_SPEED)
		move_and_slide(velocity)
		
		if vec_not_norm.x > 0:
			_change_animation("Walk")
			facing_right = true
		else:
			_change_animation("Walk-Left")
			facing_right = false
		
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

func set_wall(w):
	wall = w

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
			_change_animation("Death")
			
		

func _change_animation(animationSelected):
	for animation in $Animations.get_children():
		if animation.name != animationSelected:
			animation.hide()
		else:
			animation.show()
			$AnimationPlayer.play(animation.name)
			if animationSelected == "Death":
				alive = false
				deathCountdown = 20
				
			if animationSelected == "Attack" || animationSelected == "Attack-Left":
				not_attacking = false
				attackCountDown = 50

func _on_Zombie_melee(Melee, player_pos, zombie_pos):
	var direction = player_pos - zombie_pos
	if direction.x > 0:
		_change_animation("Attack")
	else:
		_change_animation("Attack-Left")
	attackCountDown = 30
	var scratch = Melee.instance()
	scratch.attacker = "Zombie"
	add_child(scratch)
	scratch.shoot(player_pos, zombie_pos)

func _on_Zombie_killed():
	var itemDrop = bones_scene.instance()
	itemDrop.global_position = global_position
	get_tree().get_root().add_child(itemDrop)
