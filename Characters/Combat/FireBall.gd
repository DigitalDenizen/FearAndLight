extends Area2D
var direction = Vector2()
export var speed = 850
var collid = false
var poofCountdown = 0
var attacker = ""

func shoot(aim_position, caster_position):
	global_position = caster_position
	direction = (aim_position - caster_position).normalized()
	rotation = direction.angle()

func _ready():
	pass

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

func _FireBall_body_exited(body):
	if body.is_in_group("Player"):
		attacker = "Player"

func _body_entered(body):
	if attacker == "Player":
		if body.name != "Player" && body.name != "StaticBody2D" && !body.is_in_group('CollisionBox') && !body.is_in_group('Player'):
			_fireBall_collid()
		if body.name != "Player" && body.name != "StaticBody2D" && !body.is_in_group('CollisionBox') && !body.is_in_group('Baddies'):
			body.hurt(25)
			_fireBall_collid()
		if body.name != "Player" && body.name != "StaticBody2D" && !body.is_in_group('CollisionBox') && !body.is_in_group('Objects'):
			body.hurt(25)
			_fireBall_collid()
		if body.name != "Player" && body.name != "StaticBody2D" && !body.is_in_group('CollisionBox') && !body.is_in_group('TileMaps'):
			_fireBall_collid()
		if body.name != "Player" && body.name != "StaticBody2D" && !body.is_in_group('CollisionBox') && !body.is_in_group('Structures'):
			_fireBall_collid()

func _fireBall_collid():
	collid = true
	$AnimatedSprite.play("Poof")
	poofCountdown = 1
