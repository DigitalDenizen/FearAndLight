extends Area2D
signal health_updated(health)
enum ItemDrop {HEALTH, SPIDERWEB}
export(ItemDrop) var type = ItemDrop.HEALTH
var collected = false
var collectedCountDown = 0
var health = null
var player = null

func _ready():
	player = get_parent().get_node("Player")
	add_to_group("item_drops")
	$AnimationPlayer.play("Bounce")
	$AnimatedSprite.play("SpiderWeb")

func _on_SpiderDrop_body_entered(body):
	if body.name == "Player":
		body.inventory.addPickedUpItem("SpiderWeb", Constants.imagePath.spiderweb, Constants.itemCategories.CONSUMABLE)
		queue_free()
