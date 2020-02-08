extends Area2D
var direction = Vector2()
export var speed = 1000

func shoot(aim_position, caster_position):
	global_position = caster_position
	direction = (aim_position - caster_position).normalized()
	rotation = direction.angle()

func _process(delta):
    position += direction * speed * delta

func _on_VisibilityNotifier2D_exit_screen():
	queue_free()