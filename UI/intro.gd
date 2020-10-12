extends Node2D

func _ready():
	$dog_talk.visible = false
	_enter()

func _enter():	
	$dog_enter.play("enter")	
	
func _speech():	
	$dog_enter.visible = false
	$dog_talk.visible = true
	$dog_talk.play("talk")
	
