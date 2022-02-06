extends Node

var attack_scen
onready var GAME = get_node("/root/Game")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func attack(own,pos,dir,vel_init=Vector2(0,0)):
	var go = preload("res://prefabs/Attack.tscn").instance()
	go.position = pos
	go.dir = dir
	go.vel_init = vel_init
	GAME.add_child(go)
