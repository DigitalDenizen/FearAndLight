extends CanvasLayer

var score = 0
	
func _on_Zombie_killed():
	score += 50 

func _on_DireWolf_killed():
	score += 75

func _on_VampireSpider_killed():
	score += 100
	
func _on_StoneMan_killed():
	score += 500

func _on_Wendigo_killed():
	score += 5000
	
func _on_Bush_killed():
	score += 5 

func _on_MudClump_killed():
	score += 10
	
func _on_TreeStump_killed():
	score += 10
	
func _on_TinyTree_killed():
	score += 15
	
func _on_Tree_killed():
	score += 25
	
func _on_Mushroom_killed():
	score += 25

func _update_score():
	return str(score)
