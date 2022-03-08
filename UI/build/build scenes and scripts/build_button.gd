extends Button
onready var build_menu = load("res://UI/build/build scenes and scripts/build_menu_popup.tscn").instance()

func _on_build_button_button_down():
	get_owner().add_child(build_menu)

func _on_build_button_button_up():
	build_menu.popup_centered()
	EventBus.emit_signal("build_menu_opened")
	
