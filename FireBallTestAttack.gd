extends Area2D
var direction = Vector2()
export var speed = 1000
var collid = false
var deathCountdown = 0

func shoot(aim_position, caster_position):
	global_position = caster_position
	direction = (aim_position - caster_position).normalized()
	rotation = direction.angle()

func _process(delta):
		position += direction * speed * delta

	
func _on_Visibility_exit_screen():
	queue_free()

func _body_entered(body):
	collid == true
	if body.name != "Player" && body.name != "MudWall" && body.name != "MudHut":
		body.hurt(25)
		queue_free()
	if body.name == "MudWall":
		collid = true
		speed = 0
		$AnimatedSprite.play("Death")
		
	if body.name == "MudHut":
		collid = true
		queue_free()



