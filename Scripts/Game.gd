extends Node2D


onready var playerSlider = $Slider
onready var ball = $Ball
onready var enemySlider = $EnemySlider
onready var playerScoreboard = $PlayerScoreBoard
onready var enemyScoreboard = $EnemyScoreBoard
onready var timer = $SlowMoTimer

onready var goalTimer = $GoalTimer

onready var GOALS = get_tree().get_nodes_in_group("GOAL")

onready var global= get_node("/root/Global")

var serverPosition
var serving = true

var playerScore = 0
var enemyScore = 0
var slowmo = false

var DIFFICULTY 


func _ready():
	$Slider.connect("ballBounce", ball, "_bounceOffSlider")
	playerSlider.connect("servingPos", self, "_updateBallServe")
	enemySlider.connect("ballBounce", ball, "_bounceOffSlider")
	for i in GOALS:
		i.connect("SCORED", self, "_SCORED")
		i.ball = ball
		
	DIFFICULTY = global.diff
	
	match DIFFICULTY:
		"EASY":
			enemySlider.wanderRange = 450
			enemySlider.SPEED = 450
			playerSlider.SPEED = 450
			pass
		"MODERATE":
			enemySlider.wanderRange = 200
			enemySlider.SPEED = 450
			playerSlider.SPEED = 450
		
		"UNBEATABLE":
			enemySlider.wanderRange = 30
			enemySlider.SPEED = 450
			playerSlider.SPEED = 450

# warning-ignore:shadowed_variable
func ballPass(serverPosition):
	ball.serverPosition = serverPosition
	pass

# warning-ignore:unused_argument
func _physics_process(delta):
	
	if Engine.time_scale == 1:
		if Input.is_action_pressed("ui_cancel"):
			get_tree().change_scene("res://Scenes/Title.tscn")

		
	
		 
	
	serverPosition = playerSlider.position
	if serving:
		ballPass(serverPosition)

	playerSlider.ballPosition = ball.global_position
	enemySlider.ballPosition = ball.global_position
	_traceBall()


	
func _updateBallServe(positionx):
	ball.position.x = positionx
	


func _traceBall():
	var changeA = true
	
	enemySlider.serving = ball.serving

	enemySlider.pointA = ball.position
	enemySlider.pointB = ball.position + ball.direction
	
func _SCORED(teamScored):
	print("TEAM SCORED?")
	Engine.time_scale = 0.1
	timer.start(0.2)
	
	
	
	match teamScored:
		
		
		"ENEMY":
			enemyScore += 1
			enemyScoreboard.text = convert(enemyScore, TYPE_STRING)
		
		"PLAYER":
			playerScore += 1
			playerScoreboard.text = convert(playerScore, TYPE_STRING)
	
	pass


func _on_Timer_timeout():
	Engine.time_scale = 1
	slowmo = false
	timer.stop()
		
	print("slowmo over")
	playerSlider.serving = true
	ball.serving = true
	ball.starting = true
	
	goalTimer.start(2)
	


func _on_GoalTimer_timeout():
	for i in GOALS:
		i.collisionDetection = false
