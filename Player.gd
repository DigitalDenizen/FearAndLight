extends KinematicBody2D
	
const MOVE_SPEED = 300
signal shoot(fireball, direction, location)

var FireBall = preload("res://FireBall.tscn")
var facing = "Right"

func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("zombies", "set_player", self)
	
func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		var animate = facing == "Right" ?? "Walk" : "Walk-Left"
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
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
	move_and_collide(move_vec * MOVE_SPEED * delta)
	
func kill():
	get_tree().reload_current_scene()

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			emit_signal("shoot", FireBall, rotation, position)
	
func _change_animation(animationSelected):
	for animation in $Animations.get_children():
		if animation.name != animationSelected:
			animation.hide()
		else:
			animation.show()
			$AnimationPlayer.play(animation.name)

func _on_Player_shoot(FireBall, direction, location):
	print("projectile being fired")
	var b = FireBall.instance()
	add_child(b)
	b.rotation = direction
	b.position = location
	b.velocity = b.velocity.rotated(direction)
