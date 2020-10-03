extends Area2D
enum ItemDrop2 {HEALTH, IRON}
export(ItemDrop2) var type = ItemDrop2.HEALTH
var collected = false
var collectedCountDown = 0

func _ready():
	add_to_group("item_drops")
	if type == ItemDrop2.IRON:
		$AnimatedSprite.play("iron")
	else:
		$AnimatedSprite.play("health")

func _process(delta):
	if Engine.editor_hint:
		if type == ItemDrop2.HEALTH:
			$AnimateSprite.play("health")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		collected = true
		collectedCountDown = 1
		queue_free()
