extends Particles2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	self.emitting = true
	$Particles2D.emitting = true
	$Particles2D2.emitting = true
	$Particles2D3.emitting = true
