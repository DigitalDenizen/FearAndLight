extends GridContainer
signal config()


func _on_config_pressed():
	emit_signal("config")
