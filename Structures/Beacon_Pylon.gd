extends StaticBody2D
signal beacon_activated()
signal health_updated(health)
signal killed()

export (float) var max_health = 100
onready var health = max_health setget _set_health
var alive = true
var deathCountdown = 0

func _ready():
	$Pylon_Active.visible = false
	$Pylon.visible = true
	$Pylon.play("Idle")
	add_to_group("structures")
	

func _on_Pylon_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print("it's alive")
		$Pylon.visible = false
		$Pylon_Active.visible = true
		$Pylon_Active.play("Active")
		emit_signal("beacon_activated")	


func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health <= 75 && health >= 51:
			$Pylon.play('Health 75')
			deathCountdown = 25
		if health <= 50 && health >= 26:
			$Pylon.play('Health 50')
			deathCountdown = 50
		if health <= 25 && health >= 1:
			$Pylon.play('Health 25')
			deathCountdown = 75
		if health <= 0:
			deathCountdown = 100
			alive = false
			$Pylon.play('Death')



	
