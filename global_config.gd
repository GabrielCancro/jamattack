extends Node

var attack_scen
onready var GAME = get_node("/root/Game")
onready var PLAYER = get_node("/root/Game/Player")
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

func limit(vec_orig, vec_min, vec_max):
	if vec_orig.x<vec_min.x: vec_orig.x = vec_min.x
	if vec_orig.x>vec_max.x: vec_orig.x = vec_max.x
	if vec_orig.y<vec_min.y: vec_orig.y = vec_min.y
	if vec_orig.y>vec_max.y: vec_orig.y = vec_max.y
	return vec_orig
