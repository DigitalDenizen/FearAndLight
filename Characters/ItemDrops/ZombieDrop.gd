extends Area2D
signal health_updated(health)
enum ItemDrop {HEALTH, BONES}
export(ItemDrop) var type = ItemDrop.HEALTH
var collected = false
var collectedCountDown = 0
export (float) var max_health = 100
var health = null
var player = null

func _ready():
	player = get_parent().get_node("Player")
	add_to_group("item_drops")
	$AnimationPlayer.play("Bounce")
	$AnimatedSprite.play("bones")

func _Item_Drop_body_entered(body):
	if body.name == "Player":
		body.inventory.addPickedUpItem("Bones", Constants.imagePath.bones, Constants.itemCategories.CONSUMABLE)
		queue_free()
