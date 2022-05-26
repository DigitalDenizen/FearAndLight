extends Node


#Groups
const PLAYER_GROUP : String = "Player"
const ENEMY_GROUP : String = "Baddies"
const STRUCTURES_GROUP : String = "Structures"
const OBJECTS_GROUP : String = "Objects"
const TILEMAPS_GROUP : String = "TileMaps"
const UI_GROUP : String = "UI"
const MUSHROOM_GROUP : String = "Mushrooms"
const DEFENSES_GROUP : String = "Defenses"
const BOSSES_GROUP : String = "Bosses"
const DOORS_GROUP : String = "Doors"
const TRAPS_GROUP : String = "Traps"
const CHESTS_GROUP : String = "Chests"

enum itemCategories {CONSUMABLE, TOOL, WEAPON, MATERIAL}

#Item Image Paths
const imagePath: Dictionary = {
	#EnemyDrops
	"bluemushroom": "res://Images/Drops/MushroomDrops/BlueMushroom/drop-blue-mushroom.png",
	"heart": "res://Images/Drops/ItemDrops/Heart/drop-heart.png",
	"healthpotion": "res://Images/Drops/ItemDrops/PotionHealth/drop-health-potion.png",
	"magicpotion": "res://Images/Drops/ItemDrops/MagicPotion/drop-magic-potion.png",
	"bomb": "res://Images/Drops/ItemDrops/Bomb/drop-bomb-idle.png",
	"goldcoin": "res://Images/Drops/CoinDrops/GoldCoin/drop-gold-coin.png",
	"fur": "res://Images/Drops/EnemyDrops/DireWolfFur/drop-dire-wolf-fur.png",
	"bones": "res://Images/Drops/EnemyDrops/ZombieBone/drop-zombie-bone.png",
	"spiderweb": "res://Images/Drops/EnemyDrops/VampireSpiderWeb/drop-vampire-spider-web.png",
	"mudclump": "res://Images/Drops/ResourceDrops/MudClump/drop-mud-clump.png",
	"woodlog": "res://Images/Drops/ResourceDrops/WoodLog/drop-wood-log.png",
	"stonebrick": "res://Images/Drops/ResourceDrops/StoneBrick/drop-stone-brick.png",
	"steelplate": "res://Images/Drops/ResourceDrops/SteelPlate/drop-steel-plate.png",
	"goldnugget": "res://Images/Drops/ResourceDrops/GoldNugget/drop-gold-nugget.png",
	"wendigohead": "res://Images/Drops/BossDrops/WendigoHead/drop-wendigo-head.png"
}
