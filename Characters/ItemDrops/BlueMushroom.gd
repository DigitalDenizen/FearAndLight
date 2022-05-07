extends Area2D
signal health_updated(health)
enum ItemDrop {HEALTH, BLUEMUSHROOM}
export(ItemDrop) var type = ItemDrop.HEALTH
var collected = false
var collectedCountDown = 0
export (float) var max_health = 100
var health = null
var player = null

func _ready():
	player = get_parent().get_node("Player")
	add_to_group("item_drops")
	$AnimatedSprite.play("BlueMushroom")

func _on_BlueMushroom_body_entered(body):
	if body.name == "Player":
		body.inventory.addPickedUpItem("Blue Mushroom", Constants.imagePath.bluemushroom, Constants.itemCategories.CONSUMABLE)
		queue_free()
