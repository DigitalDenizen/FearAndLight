extends PopupDialog

var battleStart = false
onready var mobSpawn = load("res://Characters/Enemies/Mob_Spawner.tscn").instance()

func _ready():
	pass

func _process(delta):
	if visible == true:
		popup_centered_minsize(Vector2(2,2))

func _on_Panel_about_to_show():
	visible = true

func _on_Timer_timeout():
	queue_free()
	mobSpawn()

func mobSpawn():
	get_tree().get_root().add_child(mobSpawn)
	mobSpawn
