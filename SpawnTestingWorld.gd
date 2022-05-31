extends Node2D

var player
export (float) var spawnNum = 0

func _ready():
	_on_SpawnTimer_timeout()
	pass
	#player = Util.get_main_node().get_node("res://Characters/Player.tscn")
#	enemySpawn()

#func enemySpawn():
#	var t = Timer.new()
#	t.set_wait_time(50)
#	print(t)
#	self.add_child(t)
#	t.start()
#	if t.wait_time > 0:
#		_on_SpawnTimer_timeout()
#	else:
#		yield(t, "timeout")
#		t.queue_free()
#		queue_free()

func _on_SpawnTimer_timeout():
	var t = Timer.new()
	t.set_wait_time(25)
	self.add_child(t)
	t.start()
	if t.wait_time > 0:
		for i in rand_range(0,spawnNum):
			var enemy = EnemyType()
			add_child(enemy)
			enemy.position = $Spawn.position
#			var area = $SpawnArea
#			var position = area.rect_position + Vector2(randf() * area.rect_size.x, randf() * area.rect_size.y)
#			$Spawn.position = position
			var nodes = get_tree().get_nodes_in_group("spawn")
			var node = nodes[randi() % nodes.size()]
			
			var position = node.position
			$Spawn.position = position
	else:
		t.stop()

func EnemyType():
	var enemyScene 
	var randn1 = RandomNumberGenerator.new()
	randn1.randomize()
	var num = randn1.randi_range(0,100)
	if num <= 33:
		print(num)
		enemyScene = preload("res://Characters/Enemies/Zombie.tscn")
		return enemyScene.instance() #returning and instancing zombie enemy
	elif num <= 66:
		print(num)
		enemyScene = preload("res://Characters/Enemies/StoneMan.tscn")
		return enemyScene.instance() #returning and instancing stone man enemy
	elif num <= 88:
		print(num)
		enemyScene = preload("res://Characters/Enemies/VampireSpider.tscn")
		return enemyScene.instance() #returning and instancing vampire spider enemy
	elif num <= 99:
		print(num)
		enemyScene = preload("res://Characters/Enemies/DireWolf.tscn")
		return enemyScene.instance() #returning and instancing dire wolf enemy
