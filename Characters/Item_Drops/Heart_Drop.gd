extends StaticBody2D
var collected = false
var collectCountDown = 5
enum ItemDrop {HEALTH, MANA, BONES}
export (ItemDrop) var type = ItemDrop.HEALTH

func _ready():
	$AnimatedSprite.play("idle")

func _process(delta):
	if collected == false:
		get_constant_linear_velocity()
	else:
		if collectCountDown <= 0:
			queue_free()
		else:
			collectCountDown -= 1

func _body_entered(body):
	if body.name == "Player":
		collected = true
		collectCountDown = 1
		queue_free()
