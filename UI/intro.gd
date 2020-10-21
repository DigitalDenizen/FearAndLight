extends Node2D

var dog_frame = 1
var dialog_text = 1

func _ready():
	$spirit_dog/speech_bubble.visible = false	

func _dog_enter():	
	$spirit_dog.play("enter")	
		
func _dog_talk():	
	$spirit_dog.play("talk")
	$spirit_dog/speech_bubble.visible = true
	_speech1()

func _on_Button_pressed():
	if dog_frame == 1:
		_dog_enter()
		print ("first click")
		dog_frame = 2
	elif dog_frame == 2:
		_dog_talk()
		print("second click")
		$Button.visible = false
		

func _speech1():
	$spirit_dog/speech_bubble/Speech1.visible = true
	$spirit_dog/speech_bubble/Speech2.visible = false
	$spirit_dog/speech_bubble/Speech3.visible = false
	$spirit_dog/speech_bubble/Speech4.visible = false
	dialog_text = 2
	
func _speech2():
	$spirit_dog/speech_bubble/Speech1.visible = false
	$spirit_dog/speech_bubble/Speech2.visible = true
	$spirit_dog/speech_bubble/Speech3.visible = false
	$spirit_dog/speech_bubble/Speech4.visible = false
	dialog_text = 3
	
func _speech3():
	$spirit_dog/speech_bubble/Speech1.visible = false
	$spirit_dog/speech_bubble/Speech2.visible = false
	$spirit_dog/speech_bubble/Speech3.visible = true
	$spirit_dog/speech_bubble/Speech4.visible = false
	dialog_text = 4

func _speech4():
	$spirit_dog/speech_bubble/Speech1.visible = false
	$spirit_dog/speech_bubble/Speech2.visible = false
	$spirit_dog/speech_bubble/Speech3.visible = false
	$spirit_dog/speech_bubble/Speech4.visible = true
	dialog_text = 1


func _on_Text_Button_pressed():
	if dialog_text == 1:
		_speech1()
	elif dialog_text == 2:
		_speech2()		
	elif dialog_text == 3:
		_speech3()
	elif dialog_text == 4:
		_speech4()


func _on_skip_button_pressed():
	get_tree().change_scene("res://UI/title-screen.tscn")
