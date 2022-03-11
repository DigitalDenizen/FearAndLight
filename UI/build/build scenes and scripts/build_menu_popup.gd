extends WindowDialog

func _ready():
	EventBus.connect("close_build_menu", self, "_on_close_build_menu")

func _on_WindowDialog_popup_hide():
	EventBus.emit_signal("build_menu_closed")
	
func _on_close_build_menu():
	if visible:
		visible = false
