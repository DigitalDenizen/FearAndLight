extends Area2D
var direction = Vector2()
export var speed = 1000
var collid = false
var webCountdown = 0

func shoot(aim_position, caster_position):
	global_position = caster_position
	direction = (aim_position - caster_position).normalized()
	rotation = direction.angle()

func _process(delta):
	if not collid:
		
		$AnimatedSprite.play("fire_web")
		position += direction * speed * delta
	else:
		if webCountdown <= 0:
			queue_free()
		else:
			webCountdown -= 1

func _on_Area2D_body_entered(body):
	collid = true
	if collid == true:
		_web_collid()
		if body.is_in_group("Player"):
			body.hurt(10)
		if body.is_in_group("Baddies"):
			collid = false
		if body.is_in_group("item drops"):
			collid = false

func _web_collid():
	collid = true
	$AnimatedSprite.flip_v = true
	$AnimatedSprite.play("web")
	webCountdown = 20
