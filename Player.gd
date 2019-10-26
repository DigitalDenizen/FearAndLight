extends KinematicBody2D

const MOVE_SPEED = 300

onready var raycast = $RayCast2D
onready var fire_ball = $"Fire-Ball"

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)
	
func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * MOVE_SPEED * delta)
	
	if Input.is_action_just_pressed("Attack"):
		var coll = fire_ball.launch(1)
			
func kill():
	get_tree().reload_current_scene()
