extends KinematicBody2D

var vel = 60
var velocity = Vector2(0,0)
var destine  = Vector2(300,300)
var idle_time = 0
var state = "idle"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	move()
	if position.distance_to( destine ) < 30: set_state("idle")
	else: set_state("walk")

func move():
	if state == "walk":
		var mov = position.direction_to( destine )
		velocity = mov * vel
		move_and_slide(velocity)
		z_index = position.y
		$Sprite/Sprite.flip_h = (destine.x < position.x)
	else: if state == "idle":
		idle_time -= 1
		if idle_time <= 0:
			idle_time = rand_range(50,250)
			destine = position + Vector2( rand_range(-200,200), rand_range(-180,180) )
			if destine.x<100: destine.x = 100
			if destine.x>900: destine.x = 900
			if destine.y<80: destine.y = 80
			if destine.y>520: destine.y = 520

func set_state(new_state):
	if state == new_state: return
	state = new_state
	if state == "idle":
		$Anim.play("idle")
	if state == "walk":
		$Anim.play("walk")

func atack():
	var dir = position.direction_to( get_global_mouse_position() )
	GC.attack( 1, position, dir, velocity )
	print("atack")
