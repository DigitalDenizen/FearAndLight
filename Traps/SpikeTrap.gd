extends Area2D

func _ready():
	$AnimatedSprite.play("Idle")
	add_to_group("Traps")

func _on_SpikeTrap_body_entered(body):
	$AnimatedSprite.play("Active")
	body.hurt(25)
