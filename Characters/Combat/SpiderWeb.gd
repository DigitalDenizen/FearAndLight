extends Area2D
var direction = Vector2()
export var speed = 750
var collid = false
var webCountdown = 0
var statusEffect  = false
var spider

func shoot(aim_position, caster_position):
	global_position = caster_position
	direction = (aim_position - caster_position).normalized()
	rotation = direction.angle()

func _process(delta):
	if not collid:
		position += direction * speed * delta
		if direction.x > 0:
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.play("fire_web")
		else:
			$AnimatedSprite.flip_v = true
			$AnimatedSprite.play("fire_web")
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
			body.hurt(10, "web")
		if body.is_in_group("Baddies"):
			collid = false
		if body.is_in_group("item drops"):
			collid = false
		if body.is_in_group("structures"):
			collid = true

func _web_collid():
	collid = true
	if global_position.x > 0:
		$AnimatedSprite.play("web")
		$AnimatedSprite.flip_v = false
	else:
		$AnimatedSprite.flip_v = true
		$AnimatedSprite.play("web")
	webCountdown = 60

