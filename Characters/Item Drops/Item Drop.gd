extends Area2D
enum ItemDrop {HEALTH, BONES}
export(ItemDrop) var type = ItemDrop.HEALTH
var collected = false
var collectedCountDown = 0

func _ready():
	if type == ItemDrop.BONES:
		$AnimatedSprite.play("Bones")
	else:
		$AnimatedSprite.play("Health")
	

func _process(delta):
	if Engine.editor_hint:
		if type == ItemDrop.HEALTH:
			$AnimateSprite.play("Health")

func _Item_Drop_body_entered(body):
	if body.name == "Player":
		collected = true
		collectedCountDown = 1
		queue_free()
