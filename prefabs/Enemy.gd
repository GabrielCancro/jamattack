extends KinematicBody2D

var speed = 60
var idle_time = 50
var team = 2
var hp = 3
var attack = 1
var persecution = false
var attack_charge = 1
onready var SM = get_node("StateMachine")


# Called when the node enters the scene tree for the first time.
func _ready():
	GC.connect("low_update",self,"low_update")

func _process(delta):
	move_ia()
	SM.update_state()
	SM.direction = position.direction_to(SM.destine)
	SM.look_dir = SM.direction
	
	if position.distance_to(GC.PLAYER.position)<70 && attack_charge >=1: 
		attack_charge = 0
		SM.look_dir = position.direction_to(GC.PLAYER.position)
		SM.set_state("attack")
		persecution = false

func low_update():
	if attack_charge<1: attack_charge += 0.18

func move_ia():
	if persecution:
		SM.destine = GC.PLAYER.position
		return
	if SM.state == "idle" and SM.state != "attack":
		idle_time -= 1
		if idle_time <= 0:
			idle_time = rand_range(50,250)
			if randf() < 0.15: 
				persecution = true
				print("PERSECUTION!!!")
			else: SM.destine = position + Vector2( rand_range(-200,200), rand_range(-180,180) )
			SM.destine = GC.limit(SM.destine,Vector2(100,80),Vector2(900,520))



func atack_with_anim():
	var dir = position.direction_to(GC.PLAYER.position)
	GC.attack( 2, position, dir, Vector2.ZERO )

func hit(dam):
	hp -= dam
	GC.blood(position)
	if hp<= 0: 
		queue_free()
		GC.addPoints(1)
		GC.spawn()
		GC.dead(self)
