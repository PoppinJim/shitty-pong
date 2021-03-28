extends Label

var goUp = true
export var fadingSpeed = 4


func _physics_process(delta):
	
	if Input.is_action_just_released("ui_accept"):
		print("Switch_Scene")
		get_tree().change_scene("res://Scenes/Difficulty Selection.tscn")
	
	match goUp:
		true: 
			modulate.a8 += fadingSpeed
			if modulate.a8 >= 100: goUp = false
		false:
			modulate.a8 -= fadingSpeed
			if modulate.a8 <= 0: goUp = true
