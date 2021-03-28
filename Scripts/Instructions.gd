extends TextureRect

var goUp = true
var begone = false

onready var timer = $Timer

export var fadingSpeed = 5

func _ready():
	timer.start(5)

func _physics_process(delta):
	
	match goUp:
		true: 
			modulate.a8 += fadingSpeed
			if modulate.a8 >= 100: goUp = false
		false:
			modulate.a8 -= fadingSpeed
			if modulate.a8 <= 0: 
				if begone == false:
					goUp = true
	pass


func _on_Timer_timeout():
	begone = true
