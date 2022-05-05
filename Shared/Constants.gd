extends Node


#Groups
const PLAYER_GROUP : String = "Player"
const ENEMY_GROUP : String = "Baddies"
const STRUCTURES_GROUP : String = "Structures"


enum itemCategories {CONSUMABLE, TOOL, WEAPON, MATERIAL}

#Item Image Paths
const imagePath: Dictionary = {
	#EnemyDrops
	"heart": "res://Images/Drops/ItemDrops/Heart/drop-heart.png",
	"healthpotion": "res://Images/Drops/ItemDrops/PotionHealth/drop-health-potion.png",
	"magicpotion": "res://Images/Drops/ItemDrops/MagicPotion/drop-magic-potion.png",
	"bomb": "res://Images/Drops/ItemDrops/Bomb/drop-bomb-idle.png",
	"bronzecoin": "res://Images/Drops/CoinDrops/BronzeCoin/drop-bronze-coin.png",
	"fur": "res://Images/Drops/EnemyDrops/DireWolfFur/drop-dire-wolf-fur.png",
	"bones": "res://Images/Drops/EnemyDrops/ZombieBone/drop-zombie-bone.png",
	"spiderweb": "res://Images/Drops/EnemyDrops/ZombieBone/drop-spider-web.png",
	"mudclump": "res://Images/Drops/ResourceDrops/MudClump/drop-mud-clump.png",
	"woodlog": "res://Images/Drops/ResourceDrops/WoodLog/drop-wood-log.png",
	"stonebrick": "res://Images/Drops/ResourceDrops/StoneBrick/drop-stone-brick.png",
	"steelplate": "res://Images/Drops/ResourceDrops/SteelPlate/drop-steel-plate.png",
	"goldnugget": "res://Images/Drops/ResourceDrops/GoldNugget/drop-gold-nugget.png",
	"bluemushroom": "res://Images/Drops/MushroomDrops/BlueMushroom/drop-blue-mushroom.png"
} 
