extends StaticBody2D

signal health_updated(health)
signal killed()

export (float) var max_health = 100
onready var health = max_health setget _set_health
var alive = true
var deathCountdown = 0
var destroyed = false
var mudhut = null
var FireBall = preload("res://FireBall.tscn")


func _ready():
	$AnimatedSprite.play("idle")
	
func _physics_process(delta):
	if destroyed == false:
		get_constant_angular_velocity()
	else:
		if deathCountdown > 0:
			deathCountdown = deathCountdown - 1
		if deathCountdown <= 0:
			queue_free()

func _on_Area2D_body_entered(body):
	if body.name == "FireBall":
		FireBall = queue_free()

func hurt(damage):
	_set_health(health - damage)

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health <= 75 && health >= 51:
			$AnimatedSprite.play('Health 75')
			deathCountdown = 25
		if health <= 50 && health >= 26:
			$AnimatedSprite.play('Health 50')
			deathCountdown = 50
		if health <= 25 && health >= 1:
			$AnimatedSprite.play('Health 25')
			deathCountdown = 75
		if health <= 0:
			deathCountdown = 100
			destroyed = true
			$AnimatedSprite.play('Death')

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



