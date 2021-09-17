extends Area2D

enum ItemDrop {FUR,HEALTH}
var collected = false
var collectedCountDown = 0
var player
export(ItemDrop) var type = ItemDrop.FUR

func _ready():
	player = get_parent().get_node("Player")
	add_to_group("item_drops")
	if type == ItemDrop.FUR:
		$AnimatedSprite.play("Fur")
	else:
		$AnimatedSprite.play("Health")

func _on_wolfDrop_body_entered(body):
	if body.name == "Player":
		collected = true
		collectedCountDown = 5
		if type == ItemDrop.HEALTH:
			body.heal(25)
			queue_free()
		else:
			queue_free()
