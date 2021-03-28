extends Node2D

onready var buttons = get_tree().get_nodes_in_group("diff")

onready var global = get_node("/root/Global")
var diff

func _on_Easy_pressed():
	_startGame("EASY")
	pass # Replace with function body.


func _on_Moderate_pressed():
	_startGame("MODERATE")
	pass # Replace with function body.


func _on_Unbeatable_pressed():
	_startGame("UNBEATABLE")
	pass # Replace with function body.

func _startGame(difficulty):
	global.diff = difficulty
	
	
	print(global.diff)
	get_tree().change_scene("res://Scenes/Game.tscn")
	
	
	
	pass
