extends Node2D

var Arrow = preload("res://UI/Cursors/Arrow.tscn")
var Pointer = preload("res://UI/Cursors/Pointer.tscn")
var Target = preload("res://UI/Cursors/Target.tscn")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	self.position = self.get_global_mouse_position()
