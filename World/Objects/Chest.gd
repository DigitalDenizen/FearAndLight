extends StaticBody2D

signal killed()

onready var collision_shape = $CollisionShape2D
onready var collision_segment = $CollisionSegment
onready var health = max_health setget _set_health
onready var itemDrop_scene = preload("res://Characters/ItemDrops/GoldCoin.tscn")
export (float) var max_health = 10
var deathCountdown = 0
var destroyed = false
var rng = RandomNumberGenerator.new()

func _ready():
	$AnimatedSprite.play("Idle")
	add_to_group("Chests")

func _physics_process(delta):
	if destroyed == false:
		get_constant_angular_velocity()
	else:
		if deathCountdown > 0:
			deathCountdown = deathCountdown - 1

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health <= 0:
			collision_shape.queue_free()
			collision_segment.queue_free()
			deathCountdown = 100
			destroyed = true
			Score._on_Object_killed()
			
			$AnimatedSprite.play('Open')
			emit_signal("killed")

func hurt(damage: int, type: String = ""):
	_set_health(health - damage)

func _on_Object_killed():
	if rng.randf() <= 1:
		var itemDrop = itemDrop_scene.instance()
		itemDrop.type = rng.randi() % 3
		get_tree().get_root().add_child(itemDrop)
		itemDrop.global_position = global_position
