extends Node2D

onready var t = $SpawnTimer

func enemySpawn():
	t.set_wait_time(10)
	t.one_shot(true)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	queue_free()
	_on_SpawnTimer_timeout()

func _on_SpawnTimer_timeout():
	if t > 0:
		var enemy = EnemyType()
		add_child(enemy)
		enemy.position = $Spawn.position
	
		var area = $SpawnArea
		var position = area.rect_position + Vector2(randf() * area.rect_size.x, randf() * area.rect_size.y)
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
