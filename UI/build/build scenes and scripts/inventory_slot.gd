extends Panel

onready var gold_nugget = preload("res://UI/build/ui-build-res-gold-nuggets-sm.png")
onready var mud_clumps = preload("res://UI/build/ui-build-res-mud-clumps-sm.png")
onready var wall = load("res://UI/build/build scenes and scripts/mud_wall_position.tscn").instance()
onready var mudhut = load("res://UI/build/build scenes and scripts/mud_hut_position.tscn").instance()

func _ready():
	#_populate_mudhut()
	_populate_wall()


func _populate_wall():
	$slot_vcontainer/slot_name_vcontainer/slot_name.text = 'MUD WALL'
	$slot_vcontainer/slot_build_panel_vcontainer/panel_hcontainer/resource_1_hcontainer/resource_1_icon_container/resource_1_icon.texture = mud_clumps
	$slot_vcontainer/slot_build_panel_vcontainer/panel_hcontainer/resource_1_hcontainer/resource_1_count_container/resource_1_count.text = "x500"
	$slot_vcontainer/slot_build_panel_vcontainer/panel_hcontainer/resource_2_hcontainer/resource_2_icon_container/resource_2_icon.texture = gold_nugget
	$slot_vcontainer/slot_build_panel_vcontainer/panel_hcontainer/resource_2_hcontainer/resource_2_count_container/resource_2_count.text = "x200"
	$slot_vcontainer/slot_button_container/button_container/button_label_container/slot_main_button.text = 'PLACE WALL'
	$slot_vcontainer/slot_build_panel_vcontainer/panel_hcontainer/building_count_hcontainer/building_count.text = 'X3'
	$slot_vcontainer/slot_main_frame_vcontainer/slot_main_frame_hcontainer/slot_main_middle_hcontainer/CenterContainer.add_child(wall)
	

func _populate_mudhut():
	$slot_vcontainer/slot_name_vcontainer/slot_name.text = 'MUD HUT'
	$slot_vcontainer/slot_build_panel_vcontainer/panel_hcontainer/resource_1_hcontainer/resource_1_icon_container/resource_1_icon.texture = mud_clumps
	$slot_vcontainer/slot_build_panel_vcontainer/panel_hcontainer/resource_1_hcontainer/resource_1_count_container/resource_1_count.text = "x700"
	$slot_vcontainer/slot_build_panel_vcontainer/panel_hcontainer/resource_2_hcontainer/resource_2_icon_container/resource_2_icon.texture = gold_nugget
	$slot_vcontainer/slot_build_panel_vcontainer/panel_hcontainer/resource_2_hcontainer/resource_2_count_container/resource_2_count.text = "x300"
	$slot_vcontainer/slot_button_container/button_container/button_label_container/slot_main_button.text = 'PLACE MUDHUT'
	$slot_vcontainer/slot_build_panel_vcontainer/panel_hcontainer/building_count_hcontainer/building_count.text = 'X1'
	$slot_vcontainer/slot_main_frame_vcontainer/slot_main_frame_hcontainer/slot_main_middle_hcontainer/CenterContainer.add_child(mudhut)
	
