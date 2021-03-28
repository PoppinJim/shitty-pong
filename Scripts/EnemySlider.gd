extends KinematicBody2D

export var pointA = Vector2.ZERO
export var pointB = Vector2.ZERO

var targetY = position.y - 40
var targetX = position.x

var findRandomTarget = true

var serving
export var SPEED = 500
var velocity = Vector2.ZERO
var direction = Vector2.ZERO

var wanderRange = 200

var distanceToTarget

var ballPosition
var directionToBall

signal ballBounce

func _ready():
	randomize()
	$Timer.start(0.75)
	
	
	
	pass

func _physics_process(delta):
	var targetY = position.y + 40
	
	
	position.y = clamp(position.y, 73, 73)
	
	distanceToTarget = position.distance_squared_to(Vector2(targetX, position.y))
	
	if serving:
		if findRandomTarget:
			targetX = rand_range(500 - wanderRange, 500 + wanderRange)
			findRandomTarget = false
			
			print("IDLING AT: ", targetX)
	
	if serving == false:
		if (pointB.y - pointA.y) < 0:
			if (pointB.x - pointA.x) != 0:
				var slope = (pointB.y - pointA.y)/(pointB.x - pointA.x)
				var yIntercept = pointA.y - slope * pointA.x
				
				targetX = targetY - yIntercept
				targetX = targetX/slope
			else:
				targetX = targetY
		
		if (pointB.y - pointA.y) > 0:
			if findRandomTarget:
				targetX = rand_range(500 - wanderRange, 500 + wanderRange)
				findRandomTarget = false
				
				print("IDLING AT: ", targetX)
			
		
	
		
		
	direction = position.direction_to(Vector2(targetX, position.y))
	velocity = direction * SPEED
	
	distanceToTarget = position.distance_to(Vector2(targetX, position.y))
	

	
	if distanceToTarget < 10:
		velocity = Vector2.ZERO
	
	
	

	
	var collision = move_and_collide(velocity * delta)
	
	directionToBall = position.direction_to(ballPosition)

	if collision:

		if collision.collider.name == "Ball":
			print("Ball Collision: ", collision.collider.name)
			emit_signal("ballBounce", directionToBall)
			pass




func _on_Timer_timeout():
	findRandomTarget = true
