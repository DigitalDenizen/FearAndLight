extends GridContainer

signal bannerClosed

func _ready():
	pass

func _on_CenterContainer2_bannerClosed():
	emit_signal("bannerClosed")
