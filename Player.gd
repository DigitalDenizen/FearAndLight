extends KinematicBody2D
	
const MOVE_SPEED = 300
signal shoot(fireball, mouse_pos, player_pos)
signal health_updated(health)
signal killed()

export (float) var max_health = 100

onready var health = max_health setget _set_health

var FireBall = preload("res://FireBall.tscn")
var facing = "Right"
var attack = 0
var move_vec

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)
	
func _physics_process(delta):
	move_vec = Vector2()
	_cool_downs()
	_player_movement()
	move_and_collide(move_vec * MOVE_SPEED * delta)

func kill():
	get_tree().reload_current_scene()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("shoot", FireBall, get_global_mouse_position(), global_position)
	
func _change_animation(animationSelected, change_dir : bool = false):
	if attack == 0 || change_dir:
		for animation in $Animations.get_children():
			if animation.name != animationSelected:
				animation.hide()
			else:
				attack = 0
				animation.show()
				$AnimationPlayer.play(animation.name)

func _on_Player_shoot(FireBall, mouse_pos, player_pos):
	var direction = mouse_pos - player_pos
	if direction.x > 0:
		_change_animation("Range", true)
	else:
		_change_animation("Range-Left", true)
	attack = 30
	var fire = FireBall.instance()
	add_child(fire)
	fire.shoot(mouse_pos, player_pos)
	
func _player_movement():
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
		
func _cool_downs():
	if attack > 0:
		attack -= 1

func damage(amount):
	_set_health(health - amount)

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health <= 0:
			kill()
