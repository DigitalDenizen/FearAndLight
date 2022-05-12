extends Area2D
signal health_updated(health)
enum ItemDrop {HEALTH, WENDIGOHEAD}
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
	$AnimatedSprite.play("WendigoHead")

func _on_WendigoItemDrop_body_entered(body):
	if body.name == "Player":
		body.inventory.addPickedUpItem("WendigoHead", Constants.imagePath.wendigohead, Constants.itemCategories.CONSUMABLE)
		queue_free()
