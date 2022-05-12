extends Area2D

enum ItemDrop {FUR,HEALTH}

func _ready():
	add_to_group("item_drops")
	$AnimationPlayer.play("Bounce")
	$AnimatedSprite.play("Fur")

func _on_wolfDrop_body_entered(body):
	if body.name == "Player":
		body.inventory.addPickedUpItem("Wolf Fur", Constants.imagePath.fur, Constants.itemCategories.CONSUMABLE)
		queue_free()
