extends KinematicBody2D

signal health_updated(health)
signal killed()

const MOVE_SPEED = 200
export (float) var max_health = 100
onready var health = max_health setget _set_health
var player = null
var dead = false
var deathCountdown = 0

func _ready():
	add_to_group("zombies")

func _physics_process(delta):
	if player == null:
		return
	if dead == false:
		var vec_not_norm = player.global_position - global_position
		var vec_to_player = vec_not_norm.normalized()
		var collision = move_and_collide(vec_to_player * MOVE_SPEED * delta)
		
		if vec_not_norm.x > 0:
			_change_animation("Walk")
		else:
			_change_animation("Walk-Left")
			
		var look_vec = get_global_mouse_position() - global_position
	else:
		deathCountdown = deathCountdown - 1
		if deathCountdown == 0:
			kill()

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
			_change_animation("Death")

func _change_animation(animationSelected):
	for animation in $Animations.get_children():
		if animation.name != animationSelected:
			animation.hide()
		else:
			animation.show()
			$AnimationPlayer.play(animation.name)
			if animationSelected == "Death":
				dead = true
				deathCountdown = 20