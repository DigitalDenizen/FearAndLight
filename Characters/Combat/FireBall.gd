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
	collid = true
	if collid == true:
		_fireBall_collid()
		if body.is_in_group("zombies"):
			body.hurt(25)
	
	if body.is_in_group("Player"):
		collid = false
	
	if body.is_in_group("Bones"):
		collid = false
	 
func _fireBall_collid():
	collid = true
	$AnimatedSprite.play("Poof")
	poofCountdown = 15
