extends Area2D
var direction = Vector2()
export var speed = 0
var collid = false
var poofCountdown = 0
var attacker = ""

func shoot(aim_position, caster_position):
	global_position = caster_position
	direction = (aim_position - caster_position).normalized()
	rotation = direction.angle()

func _ready():
	speed = 100

func _process(delta):
	if not collid:
		position += direction * speed * delta
	else:
		if poofCountdown <= 0:
			queue_free()
		else:
			poofCountdown -= 1
	if speed > 0:
		speed = speed - 2.2
	else:
		queue_free()
	
func _on_Visibility_exit_screen():
	queue_free()

func _body_entered(body):
	if attacker == "Player":
		if body.is_in_group('Player'):
			_melee_collid()
		if body.name != "Player" && body.name != "StaticBody2D" && !body.is_in_group('CollisionBox') && !body.is_in_group('Baddies'):
			body.hurt(25)
			_melee_collid()
		if body.name != "Player" && body.name != "StaticBody2D" && !body.is_in_group('CollisionBox') && !body.is_in_group('Objects'):
			body.hurt(25)
			_melee_collid()
		if body.name != "Player" && body.name != "StaticBody2D" && !body.is_in_group('CollisionBox') && !body.is_in_group('TileMaps'):
			_melee_collid()
		if body.name != "Player" && body.name != "StaticBody2D" && !body.is_in_group('CollisionBox') && !body.is_in_group('Structures'):
			_melee_collid()
	elif attacker == "Zombie":
		if !body.is_in_group('Baddies') && !body.is_in_group('CollisionBox') && !body.is_in_group('tileMap'):
			body.hurt(10)
			_melee_collid()
	elif attacker == "vampireSpider":
		if !body.is_in_group("Baddies") && !body.is_in_group('CollisionBox'):
			body.hurt(10)
			_melee_collid()
	elif attacker == "direWolf":
		if !body.is_in_group("Baddies") && !body.is_in_group('CollisionBox') && !body.is_in_group('tileMap'):
			body.hurt(10)
			_melee_collid()
	elif attacker == "Wendigo":
		if !body.is_in_group("Baddies") && !body.is_in_group('CollisionBox') && !body.is_in_group('tileMap'):
			body.hurt(30)
			_melee_collid()

func _melee_collid():
	collid = true
	$AnimatedSprite.play("Poof")
	poofCountdown = 1
