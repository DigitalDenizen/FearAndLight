extends CanvasLayer

var score = 0
	
func _on_Zombie_killed():
	score += 50 

func _update_score():
	return str(score)
