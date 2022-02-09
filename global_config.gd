extends Node

var attack_scen
var score = 0
onready var GAME = get_node("/root/Game")
onready var PLAYER = get_node("/root/Game/Player")
signal low_update

# Called when the node enters the scene tree for the first time.
func _ready():
	start_low_update_timer()

func attack(own,pos,dir,vel_init=Vector2(0,0)):
	var go = preload("res://prefabs/Attack.tscn").instance()
	go.own = own
	go.position = pos
	go.dir = dir
	go.vel_init = vel_init
	GAME.add_child(go)

func spawn():
	var en = preload("res://prefabs/Enemy.tscn").instance()
	en.team = 2
	en.position = PLAYER.position
	while en.position.distance_to(PLAYER.position) < 150:
		en.position = Vector2( rand_range(100,924), rand_range(80,520) )
	GAME.add_child(en)

func limit(vec_orig, vec_min, vec_max):
	if vec_orig.x<vec_min.x: vec_orig.x = vec_min.x
	if vec_orig.x>vec_max.x: vec_orig.x = vec_max.x
	if vec_orig.y<vec_min.y: vec_orig.y = vec_min.y
	if vec_orig.y>vec_max.y: vec_orig.y = vec_max.y
	return vec_orig

func start_low_update_timer():
	var timer = Timer.new()
	timer.set_wait_time(.2)
	timer.connect("timeout", self, "low_update_emiter")
	get_node("/root/Game").add_child(timer)
	timer.start()

func low_update_emiter():
	emit_signal("low_update")

func addPoints(scr):
	score += scr
	GAME.get_node("lb_score").text = "ASESINATOS: "+str(score)
