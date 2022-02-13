extends Node

var intro_time = 0
var attack_scen
var score = 0
var objetive_score = 1
var GAME
var PLAYER
signal low_update

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func init():
	GAME = get_node("/root/Game")
	PLAYER = get_node("/root/Game/Player")
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
	GAME.get_node("Enemies").add_child(en)
	return en

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
	GAME.get_node("UI/lb_score").text = "ALMAS ERRANTES: "+str(objetive_score-score)
	if score == objetive_score: win_game()
		

func blood(pos):
	var blood = preload("res://prefabs/Blood.tscn").instance()
	blood.emitting = true
	blood.one_shot = true
	blood.position = pos
	blood.z_index = pos.y + 4
	GAME.add_child(blood)

func dead(own):
	var dead = preload("res://prefabs/Dead.tscn").instance()
	dead.position = own.position
	if own.get_node("Sprite").scale.x<0: dead.scale.x *= -1
	dead.z_index = dead.position.y
	GAME.get_node("Deads").add_child(dead)
	
func end_game():
	PLAYER.position.y = -5000
	yield(get_tree().create_timer(3),"timeout")
	PLAYER.hp = 5
	score = 0
	get_tree().change_scene("res://scenes/Main.tscn")

func win_game():
	yield(get_tree().create_timer(3),"timeout")
	get_tree().change_scene("res://scenes/Win.tscn")
