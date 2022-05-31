extends YSort

onready var ground = $Ground
onready var pathFinding = $PathFinding
onready var mobSpawner = $MobSpawn

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
	var t = Timer.new()
	t.set_wait_time(25)
	self.add_child(t)
	t.start()
	for i in rand_range(0,10):
		if t.wait_time > 0:
			var enemy = EnemyType()
			add_child(enemy)
			enemy.position = $Spawn.position
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
