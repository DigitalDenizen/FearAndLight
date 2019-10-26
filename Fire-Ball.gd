extends KinematicBody2D

const THROW_VELOCITY = Vector2(800, 0)

var velocity = Vector2.ZERO
var location

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		_on_impact(collision.collider)

func launch(direction):
	location = global_transform
	var scene = get_tree().current_scene
	get_parent().remove_child(self)
	scene.add_child(self)
	global_transform = location
	velocity = THROW_VELOCITY * Vector2(direction, 1)
	set_physics_process(true)

func _on_impact(coll: Object):
	if coll.name == "Player":
		pass
	else:
		global_transform = location
		set_physics_process(false)
		get_parent().add_child(self)
		coll.kill()