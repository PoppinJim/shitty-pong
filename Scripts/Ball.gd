extends KinematicBody2D

var velocity = Vector2.ZERO
var SPEED = 520
var serverPosition = Vector2.ZERO
var starting = true
var serving = true




export var direction = Vector2.ZERO

func _bounceOffSlider(directionX):
	direction = directionX
	serving = false

func _ready():
	
	pass
	
func _physics_process(delta):
	
	
	if serving:
		direction = Vector2.ZERO

		if starting:
			position.x = serverPosition.x
			position.y = serverPosition.y - 50
			starting = false
		
		
	


	
	velocity.x = SPEED * direction.x
	velocity.y = SPEED * direction.y
	
	
	##MOVEMENT AND BOUNCE
	
	var collision = move_and_collide(velocity * delta)
	
	
	if collision:
		
		direction = direction.bounce(collision.normal)
		
	 
	 
	pass
