extends Timer

export var min_wait_time = 0.5
export var max_wait_time = 2.0


# Called when the node enters the scene tree for the first time.
func _ready():
	if autostart:
		random_start()
		

func random_start(time = rand_range(min_wait_time,max_wait_time)):
	start(time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
