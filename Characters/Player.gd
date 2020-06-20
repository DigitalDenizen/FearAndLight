extends KinematicBody2D
	
const MOVE_SPEED = 300
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

var FireBall = preload("res://Characters/Combat/FireBall.tscn")
var Melee = preload("res://Characters/Combat/Melee.tscn")
var facing = "Right"
var move_vec

func _ready():
	yield(get_tree(), "idle_frame")
	add_to_group("Player")
	get_tree().call_group("zombies", "set_player", self)
	
func _physics_process(delta):
	move_vec = Vector2()
	_player_movement()
	move_and_collide(move_vec * MOVE_SPEED * delta)

func kill():
	queue_free()

func _input(event):
	if event is InputEventMouseButton && alive:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("shoot", FireBall, get_global_mouse_position(), global_position)
		if event.button_index == BUTTON_RIGHT and event.pressed:
			emit_signal("melee", Melee, get_global_mouse_position(), global_position)

func _change_animation(animationSelected, change_dir : bool = false):
	if not attacking || change_dir:
		for animation in $Animations.get_children():
			if animation.name != animationSelected:
				animation.hide()
			else:
				animation.show()
				$AnimationPlayer.play(animation.name)

func _on_Player_shoot(FireBall, mouse_pos, player_pos):
	var direction = mouse_pos - player_pos
	if direction.x > 0:
		_change_animation("Range", true)
	else:
		_change_animation("Range-Left", true)
	_set_attack(30)
	var fire = FireBall.instance()
	add_child(fire)
	fire.shoot(mouse_pos, player_pos)
	
func _on_Player_melee(Melee, mouse_pos, player_pos):
	var direction = mouse_pos - player_pos
	if direction.x > 0:
		_change_animation("Attack", true)
	else:
		_change_animation("Attack-Left", true)
	_set_attack(30)
	var punch = Melee.instance()
	punch.attacker = "Player"
	add_child(punch)
	punch.shoot(mouse_pos, player_pos)
	
func _player_movement():
	if alive && not attacking:
		if Input.is_action_pressed("move_up"):
			var animate = "Walk" if facing == "Right" else "Walk-Left"
			_change_animation(animate)
			move_vec.y -= 1
		if Input.is_action_pressed("move_down"):
			var animate = "Walk" if facing == "Right" else "Walk-Left"
			_change_animation(animate)
			move_vec.y += 1
		if Input.is_action_pressed("move_left"):
			facing = "Left"
			_change_animation("Walk-Left")
			move_vec.x -= 1
		if Input.is_action_pressed("move_right"):
			facing = "Right"
			_change_animation("Walk")
			move_vec.x += 1
		if move_vec.x == 0 && move_vec.y == 0 && facing == "Right":
			_change_animation("Idle")
		if move_vec.x == 0 && move_vec.y == 0 && facing == "Left":
			_change_animation("Idle-Left")
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

func hurt(damage):
	_set_health(health - damage)

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
			_change_animation("Death")
			
func _set_attack(animTime):
	attackCountdown = animTime
	attacking = true
