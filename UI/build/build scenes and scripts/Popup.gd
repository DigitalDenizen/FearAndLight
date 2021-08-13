extends Popup

func _on_Button_pressed():
	popup_centered_ratio(.55)
	$Container/Tabs/WindowDialog.popup()
	print("popup")
