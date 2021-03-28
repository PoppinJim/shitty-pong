extends KinematicBody2D

var dir = Vector2.ZERO
var velocity = Vector2.ZERO
var ballPosition
var directionToBall
onready var sliderPoint = $Position2D
var slideRight = true
var slideSpeed = 5
var serving = true

var goUp = true

export var SPEED = 400

signal ballBounce
signal servingPos




func _physics_process(delta):
	position.y = clamp(position.y, 521, 521)
	
	$Arrow.visible = false
	$Arrow.look_at(ballPosition)
	if position.distance_to(ballPosition) < 250:
	
		var fadingSpeed = 5
		match goUp:
			true: 
				$Arrow.modulate.a8 += fadingSpeed
				if $Arrow.modulate.a8 >= 125: goUp = false
			false:
				$Arrow.modulate.a8 -= fadingSpeed
				if $Arrow.modulate.a8 <= 0: goUp = true
		
		$Arrow.visible = true
	
	###SLIDER
	if slideRight:
		sliderPoint.position.x += slideSpeed
		if (sliderPoint.position.x) >= 50:
			slideRight = false
	else:
		sliderPoint.position.x -= slideSpeed
		if (sliderPoint.position.x) <= -50:
			slideRight = true
	

	
	###CONTROLS
	
#	if Input.is_action_pressed("Shift"): SPEED = SPEED/2
#	if Input.is_action_pressed("Z-Key"): SPEED = SPEED * 2
#	SPEED = clamp(SPEED, 200, 800)
	
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = dir.x * SPEED	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
	
		if collision.collider.name == "Ball":
			print("Ball Collision: ", collision.collider.name)
			emit_signal("ballBounce", directionToBall)
			pass
			
	directionToBall = position.direction_to(ballPosition)
	
	if serving:
		emit_signal("servingPos", sliderPoint.position.x + position.x)
	
		if Input.is_action_just_released("ui_accept"):
			emit_signal("ballBounce", directionToBall)
			serving = false
	
	



