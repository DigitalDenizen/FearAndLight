extends HBoxContainer

func _process(delta):
	$ScoreNumber.text = Score._update_score()
