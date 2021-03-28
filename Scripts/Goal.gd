extends Area2D

export var teamScored = "PLAYER"


var collisionDetection = false
var ball

signal SCORED

func _physics_process(delta):
	
	if overlaps_body(ball):
		emit_signal("SCORED", teamScored)
		collisionDetection = true
		
	$CollisionShape2D.disabled = collisionDetection


