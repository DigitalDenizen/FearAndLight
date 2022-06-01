extends YSort

onready var ground = $Ground
onready var pathFinding = $PathFinding
onready var mobSpawner = $MobSpawn

export (int) var spawnNum = 0
export (int) var wavenum = 1
var enemyWavesSpawned = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pathFinding.createNavigationMap(ground)
	#mobSpawner.initialize(pathFinding)
	EventBus.connect("build_menu_opened",self, "on_build_menu_opened")
	EventBus.connect("build_menu_closed",self, "on_build_menu_closed")
	
	EventBus.connect("battle_banner_closed", self,"on_battle_banner_clsoed") # When this signal is received run the closed banner function
	
#func on_build_menu_opened():
#	get_tree().paused = true
#
#func on_build_menu_closed():
#	get_tree().paused = false
	
func on_battle_banner_clsoed():
	mobSpawner.initialize(pathFinding)

func spawn():
	#Spawn new wave is the waves spawned is less then wave number
	while enemyWavesSpawned < wavenum:
		for i in rand_range(0,spawnNum):
			var enemy = EnemyType()
			add_child(enemy)
			enemy.pathFinding = self.pathFinding
			enemy.position = $Spawn.position
			var nodes = get_tree().get_nodes_in_group("spawn")
			var node = nodes[randi() % nodes.size()]
			var position = node.position
			$Spawn.position = position
		#Increase waves spawned by 1
		enemyWavesSpawned = enemyWavesSpawned + 1
		break

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
	else:
		print(num)
		enemyScene = preload("res://Characters/Enemies/DireWolf.tscn")
		return enemyScene.instance() #returning and instancing dire wolf enemy

func _on_SpawnTimer_timeout():
	spawn()
