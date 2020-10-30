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
	if type == ItemDrop.BONES:
		$AnimatedSprite.play("bones")
	else:
		$AnimatedSprite.play("health")

func _Item_Drop_body_entered(body):
	if body.name == "Player":
		collected = true
		collectedCountDown = 5
		if type == ItemDrop.HEALTH:
			body.heal(25)
			queue_free()
		if type == ItemDrop.BONES:
			queue_free()
