extends Area2D
var direction = Vector2()
export var speed = 1000
var collid = false
var poofCountdown = 0

func shoot(aim_position, caster_position):
	global_position = caster_position
	direction = (aim_position - caster_position).normalized()
	rotation = direction.angle()

func _process(delta):
	if not collid:
		$AnimatedSprite.play("Fire")
		position += direction * speed * delta
	else:
		if poofCountdown <= 0:
			queue_free()
		else:
			poofCountdown -= 1
	
func _on_Visibility_exit_screen():
	queue_free()

func _body_entered(body):
	
	if body.name != "Player" && body.name != "MudWall" && body.name != "MudHut":
		body.hurt(25)
		_fireBall_collid()
	if body.name == "MudWall" || body.name == "MudHut" :
		_fireBall_collid()

func _fireBall_collid():
	collid = true
	$AnimatedSprite.play("Poof")
	poofCountdown = 15
