extends KinematicBody2D
	
const MOVE_SPEED = 90
const ACCELERATION = 100
const FRICTION = 100
signal shoot(fireball, mouse_pos, player_pos)
signal melee(melee, mouse_pos, player_pos)
signal health_updated(health)
signal killed()

export (float) var max_health = 100
onready var health = max_health setget _set_health
var alive = true
var attacking = false
var deathCountdown = 0
var attackCountdown = 0
var statusEffect = false
var statusEffectCountDown
var statusCooldown
var items = []

var FireBall = preload("res://Characters/Combat/FireBall.tscn")
var Melee = preload("res://Characters/Combat/Melee.tscn")
var inventory
var facing = "Right"
var move_vec

func _ready():
	yield(get_tree(), "idle_frame")
	add_to_group("Player")
	get_tree().call_group("zombies", "set_player", self)
	inventory = get_node("Camera2D/Overlay/Inventory")
	
func _physics_process(delta):
	move_vec = Vector2()
	_player_movement(delta)
	move_and_slide(move_vec * MOVE_SPEED)

func kill():
	queue_free()

func _input(event):
	if event is InputEventMouseButton && alive:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("shoot", FireBall, get_global_mouse_position(), global_position)
		if event.button_index == BUTTON_RIGHT and event.pressed:
			emit_signal("melee", Melee, get_global_mouse_position(), global_position)
#Trying to make the melee and shoot buttons work on the controller
	#if Input.is_action_just_pressed("melee"):
			#emit_signal("melee", Melee, Vector2.ZERO, global_position)
	#if Input.is_action_just_pressed("shoot"):
			#emit_signal("shoot", Melee, Vector2.ZERO, global_position)

func _on_Player_shoot(FireBall, mouse_pos, player_pos):
	var direction = mouse_pos - player_pos
	if direction.x > 0:
		$AnimatedSprite.play("throw")
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("throw")
		$AnimatedSprite.flip_h = true
		facing == "Left"
	_set_attack(30)
	var fire = FireBall.instance()
	fire.attacker = "Player"
	add_child(fire)
	fire.shoot(mouse_pos, player_pos)
	$SoundFireBall.play()
	
func _on_Player_melee(Melee, mouse_pos, player_pos):
	var direction = mouse_pos - player_pos
	if direction.x > 0:
		$AnimatedSprite.play("melee")
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("melee")
		$AnimatedSprite.flip_h = true
	_set_attack(30)
	var punch = Melee.instance()
	punch.attacker = "Player"
	add_child(punch)
	punch.shoot(mouse_pos, player_pos)
	
func _player_movement(delta):
	if alive && not attacking:
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		input_vector = input_vector.normalized()
		
		if input_vector != Vector2.ZERO:
			
			if input_vector.x > 0:
				facing = "Right"
				$AnimatedSprite.play("walk")
				$AnimatedSprite.flip_h = false
				
			else:
				facing = "Left"
				$AnimatedSprite.play("walk")
				$AnimatedSprite.flip_h = true
			move_vec = move_vec.move_toward(input_vector * MOVE_SPEED, ACCELERATION * delta)
		else:
			$SoundWalk.stop()
			if facing == "Right":
				$AnimatedSprite.play("idle")
				$AnimatedSprite.flip_h = false
			else:
				$AnimatedSprite.play("idle")
				$AnimatedSprite.flip_h = true
			move_vec = move_vec.move_toward(Vector2.ZERO, FRICTION * delta)
	else:
		if not alive:
			if deathCountdown == 0:
				kill()
			else:
				deathCountdown = deathCountdown - 1
		else:
			attackCountdown -= 1
			if attackCountdown <= 0:
				attacking = false
				

func hurt(damage: int, type: String = ""):
	_set_health(health - damage)
	if type == "web":
		statusEffect = true
		statusEffectCountDown = 75

	
func heal(healing):
	_set_health(health + healing)
	$SoundHeal.play()
	
func stuck(hold):
	statusEffect = true
	if statusEffect == true:
		MOVE_SPEED - hold

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health <= 0:
			alive = false
			attacking = false
			attackCountdown = 0
			deathCountdown = 100
			$AnimatedSprite.play("death")
			
func _set_attack(animTime):
	attackCountdown = animTime
	attacking = true
