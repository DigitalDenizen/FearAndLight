extends Node2D

var dog_frame = 1
var dialog_text = 0
onready var collision_shape = $CollisionShape2D

func _ready():
	_speech0()
	_move()
	add_to_group("Objects")

func _move():
	$spirit_dog/AnimationPlayer.play("move")
	
	
func _talk():
	$spirit_dog/AnimationPlayer.play("talk")


func _speech0():
	$speech_bubble/speech_bubble1.visible = false
	$speech_bubble/speech_bubble2.visible = false
	$speech_bubble/speech_bubble3.visible = false
	$speech_bubble/speech_bubble4.visible = false
	$speech_bubble/speech_bubble5.visible = false
	$speech_bubble/speech_bubble6.visible = false
	$speech_bubble/speech_bubble7.visible = false
	$speech_bubble/speech_bubble8.visible = false
	$speech_bubble/speech_bubble9.visible = false
	$skip_button.visible = false
	$speech_bubble/next_button.visible = false
	dialog_text = 1


func _speech1():
	$speech_bubble/speech_bubble1.visible = true
	$speech_bubble/next_button.visible = true
	$skip_button.visible = true
	dialog_text = 2
	
func _speech2():
	$speech_bubble/speech_bubble1.visible = false
	$speech_bubble/speech_bubble2.visible = true
	dialog_text = 3
	
func _speech3():

	$speech_bubble/speech_bubble2.visible = false
	$speech_bubble/speech_bubble3.visible = true
	dialog_text = 4

func _speech4():
	$speech_bubble/speech_bubble3.visible = false
	$speech_bubble/speech_bubble4.visible = true
	dialog_text = 5
	
func _speech5():
	$speech_bubble/speech_bubble4.visible = false
	$speech_bubble/speech_bubble5.visible = true
	dialog_text = 6
	
func _speech6():
	$speech_bubble/speech_bubble5.visible = false
	$speech_bubble/speech_bubble6.visible = true
	dialog_text = 7
	
func _speech7():
	$speech_bubble/speech_bubble6.visible = false
	$speech_bubble/speech_bubble7.visible = true
	dialog_text = 8
	
func _speech8():
	$speech_bubble/speech_bubble7.visible = false
	$speech_bubble/speech_bubble8.visible = true
	dialog_text = 9

func _speech9():
	$speech_bubble/speech_bubble8.visible = false
	$speech_bubble/speech_bubble9.visible = true
	dialog_text = 10
	



func _on_Text_Button_pressed():
	if dialog_text == 1:
		_speech1()
	elif dialog_text == 2:
		_speech2()
	elif dialog_text == 3:
		_speech3()
	elif dialog_text == 4:
		_speech4()
	elif dialog_text == 5:
		_speech5()
	elif dialog_text == 6:
		_speech6()
	elif dialog_text == 7:
		_speech7()
	elif dialog_text == 8:
		_speech8()
	elif dialog_text == 9:
		_speech9()
	elif dialog_text == 10:
		queue_free()
		#get_tree().change_scene("res://UI/title-screen.tscn")


func _on_skip_button_pressed():
	if dialog_text == 1:
		_speech1()
	elif dialog_text == 2:
		_speech2()
	elif dialog_text == 3:
		_speech3()
	elif dialog_text == 4:
		_speech4()
	elif dialog_text == 5:
		_speech5()
	elif dialog_text == 6:
		_speech6()
	elif dialog_text == 7:
		_speech7()
	elif dialog_text == 8:
		_speech8()
	elif dialog_text == 9:
		_speech9()
	elif dialog_text == 10:
		queue_free()
		#get_tree().change_scene("res://UI/title-screen.tscn")
	
	#if dialog_text == 6:
		#get_tree().change_scene("res://UI/title-screen.tscn")
		


func _on_AnimationPlayer_animation_finished(move):
	_talk()
	_speech1()



	



	
