extends StaticBody2D

signal defenseDestroyed()
signal health_updated(health)
signal killed()

export (float) var max_health = 75
onready var collision_shape = $CollisionShape2D
onready var health = max_health setget _set_health
var destroyed = false
var deathCountdown = 0
var attacked = false
var attacker = ""

func _ready():
	$AnimatedSprite.play("idle")
	add_to_group("Structures")
	
func _physics_process(delta):
	if destroyed == false:
		get_constant_linear_velocity()
	else:
		if deathCountdown > 0:
			deathCountdown = deathCountdown - 1
		if deathCountdown <= 0:
			queue_free()

func hurt(damage):
	_set_health(health - damage)
	
func _on_DefenseRange_body_entered(body):
	if body.name == "FireBall":
		queue_free()
	if body.name == "Zombie" || body.name == "vampireSpider" || body.name == "direWolf":
		attacked = true

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health <= 54 && health >= 37:
			$AnimatedSprite.play('Health 75')
			deathCountdown = 25
		if health <= 36 && health >= 19:
			$AnimatedSprite.play('Health 50')
			deathCountdown = 50
		if health <= 18 && health >= 1:
			$AnimatedSprite.play('Health 25')
			deathCountdown = 75
		if health <= 0:
			emit_signal("defenseDestroyed")
			deathCountdown = 100
			destroyed = true
			$AnimatedSprite.play('Death')
			$explosion2.visible = true
			
