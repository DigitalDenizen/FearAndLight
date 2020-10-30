extends Area2D
var direction = Vector2()
export var speed = 0
var attacker = ""

func shoot(aim_position, caster_position):
	global_position = caster_position
	direction = (aim_position - caster_position).normalized()
	rotation = direction.angle()

func _ready():
	speed = 100

func _process(delta):
	position += direction * speed * delta
	if speed > 0:
		speed = speed - 0.5
	else:
		queue_free()

func _on_Visibility_exit_screen():
	queue_free()

func _body_entered(body):
	if attacker == "Player":
		if body.name != "Player" && body.name != "StaticBody2D" && !body.is_in_group('CollisionBox'):
			body.hurt(25)
			queue_free()
	elif attacker == "Zombie":
		if !body.is_in_group('Baddies') && !body.is_in_group('CollisionBox'):
			body.hurt(10)
			queue_free()
	elif attacker == "vampireSpider":
		if !body.is_in_group("Baddies") && !body.is_in_group('CollisionBox'):
			body.hurt(10)
			queue_free()
	
