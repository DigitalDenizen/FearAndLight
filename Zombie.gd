extends KinematicBody2D

const MOVE_SPEED = 200

var player = null

func _ready():
	add_to_group("zombies")

func _physics_process(delta):
	if player == null:
		return
	
	var vec_not_norm = player.global_position - global_position
	var vec_to_player = vec_not_norm.normalized()
	var collision = move_and_collide(vec_to_player * MOVE_SPEED * delta)
	
	if collision != null:
		print(player.get_property_list())
		print('#################################################################')
		print(collision.collider.get_property_list())
	
	if vec_not_norm.x > 0:
		_change_animation("Walk")
	else:
		_change_animation("Walk-Left")
		
	var look_vec = get_global_mouse_position() - global_position

func kill():
	queue_free()

func set_player(p):
	player = p
	
func _change_animation(animationSelected):
	for animation in $Animations.get_children():
		if animation.name != animationSelected:
			animation.hide()
		else:
			animation.show()
			$AnimationPlayer.play(animation.name)