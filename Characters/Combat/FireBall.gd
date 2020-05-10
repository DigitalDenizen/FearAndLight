extends Area2D
var direction = Vector2()
export var speed = 1000

func shoot(aim_position, caster_position):
	global_position = caster_position
	direction = (aim_position - caster_position).normalized()
	rotation = direction.angle()

func _process(delta):
	position += direction * speed * delta

func _on_Visibility_exit_screen():
	queue_free()

func _body_entered(body):
	if body.name != "Player" && body.name != "StaticBody2D":
		body.hurt(25)
		queue_free()
