extends Area2D
enum ItemDrop {HEALTH, BONES}
export(ItemDrop) var type = ItemDrop.HEALTH
var collected = false
var collectedCountDown = 0

func _ready():
	add_to_group("item_drops")
	if type == ItemDrop.BONES:
		$AnimatedSprite.play("bones")
	else:
		$AnimatedSprite.play("health")

func _process(delta):
	if Engine.editor_hint:
		if type == ItemDrop.HEALTH:
			$AnimateSprite.play("health")

func _Item_Drop_body_entered(body):
	if body.name == "Player":
		collected = true
		collectedCountDown = 1
		queue_free()
