extends Camera2D

func _process(delta):

	if is_current():
	Globals.set("currentCamera", self)