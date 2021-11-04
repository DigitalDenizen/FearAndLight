extends Node
class_name MobSpawner

signal victory(enemies, heroes, defenses)

export (float) var shape_x = 0.0
export (float) var shape_y = 0.0
export (int) var spawn_num = 0

var pathFinding: PathFinding
var waveSize = 0
var enemiesKilled = 0
var heroesKilled = 0
var defensesDestroyed = 0

func initialize(pathFinding: PathFinding):
	self.pathFinding = pathFinding
	spawn(self)

func spawn(mobSpawner):
	var colShape = $Spawn_area
	if shape_x != 0.0 && shape_y != 0.0:
		colShape.shape.extents = Vector2(shape_x/2, shape_y/2)

	var rand = RandomNumberGenerator.new()
	waveSize = spawn_num
	var center = colShape.position
	var size = colShape.shape.extents
	var screen_size = get_viewport().get_visible_rect().size
	for i in range(0,spawn_num):
		var enemy = enemyType()
		enemy.spawner = mobSpawner
		enemy.waveSpawn = true
		enemy.max_health = 150
		enemy.add_to_group('Baddies')
		enemy.position.y = (randi() % int(size.x)) - (int(size.x/2)) + center.x
		enemy.position.x = (randi() % int(size.y)) - (int(size.y/2)) + center.y
		enemy.pathFinding = pathFinding
		add_child(enemy)

func removeEnemy():
	waveSize = waveSize - 1
	enemiesKilled = enemiesKilled + 1
	if waveSize == 0:
		emit_signal("victory", enemiesKilled, heroesKilled, defensesDestroyed)
		
func heroKilled():
	heroesKilled = heroesKilled + 1

func defenseDestroyed():
	defensesDestroyed = defensesDestroyed + 1

func enemyType():
	var enemyScene 
	var randn1 = RandomNumberGenerator.new()
	randn1.randomize()
	var num = randn1.randi_range(0,100)
	if num >= 50:
		enemyScene = preload("res://Characters/Enemies/Zombie.tscn")
		return enemyScene.instance() #returning and intacing enemy
		
	else:
		enemyScene = preload("res://Characters/Enemies/direWolf.tscn")
		return enemyScene.instance() #returning and intacing enemy
