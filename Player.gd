extends KinematicBody2D

const MOVE_SPEED = 300
signal shoot(bullet, direction, location)

onready var raycast = $RayCast2D
onready var fire_ball = $"Fire-Ball"
var FireBall = preload("res://Fire-Ball.tscn")

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
	
func kill():
	get_tree().reload_current_scene()
	
func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and event.pressed:
            emit_signal("shoot", FireBall, rotation, position)

func _process(delta):
    look_at(get_global_mouse_position())
	
func _on_Player_shoot(fireball, direction, location):
    var b = FireBall.instance()
    add_child(b)
    b.position = location
    b.velocity = b.velocity.rotated(direction)
