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
var wendigoKilled = 0

func _ready():
	EventBus.connect("battle_banner_closed",self,"spawn")

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

func spawnWendigo(mobSpawner):
	#Setting shape of spawning area
	var colShape = $Spawn_area
	if shape_x != 0.0 && shape_y != 0.0:
		colShape.shape.extents = Vector2(shape_x/2, shape_y/2)


	var center = colShape.position
	var size = colShape.shape.extents
	var screen_size = get_viewport().get_visible_rect().size
	var wendigoSpawn = wendigoSpawn()
	
	#Determining the spawn position of the enemy
	wendigoSpawn.spawner = mobSpawner
	wendigoSpawn.max_health = 500
	wendigoSpawn.add_to_group("Bosses")
	wendigoSpawn.position.y = (randi() % int(size.x)) - (int(size.x/2)) + center.x
	wendigoSpawn.position.x = (randi() % int(size.y)) - (int(size.y/2)) + center.y
	wendigoSpawn.pathFinding = pathFinding
	add_child(wendigoSpawn)

func removeEnemy():
	waveSize = waveSize - 1
	enemiesKilled = enemiesKilled + 1
	if waveSize == 0:
		spawnWendigo(self)
		print("wave defeated")

func heroKilled():
	heroesKilled = heroesKilled + 1

func defenseDestroyed():
	defensesDestroyed = defensesDestroyed + 1

func wendigoDefeated():
	wendigoKilled = wendigoKilled - 1

func enemyType(): #Enemy type selection 
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
		
	else:
		removeEnemy()

func wendigoSpawn(): #Spawn the wendigo when spawn is defeated
	var wendigoScene = preload("res://Characters/Bosses/Wendigo.tscn")
	var wendigo = wendigoScene
	return wendigo.instance()

func MobsDefeated(): 
	EventBus.emit_signal("victory",enemiesKilled, heroesKilled, defensesDestroyed)
