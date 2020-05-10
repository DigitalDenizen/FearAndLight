extends CanvasLayer

var score = 0

func _process(delta):
	
	$ScoreNumber.text = str(score)
	
func _on_Zombie_killed():
	score += 50 
	update()
		

func update():
	$ScoreNumber.text += str(int(score))
