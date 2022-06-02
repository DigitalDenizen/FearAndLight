extends Area2D

var player = null

func _ready():
	player = Util.get_main_node().get_node("YSort/Player")
	$AnimatedSprite.play("Idle")
	add_to_group("Traps")

func _on_FlipPitTrap_body_entered(body):
	$AnimatedSprite.play("Active")
	body.hurt(10000)
	player.hide()
