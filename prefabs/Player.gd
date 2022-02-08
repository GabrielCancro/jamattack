extends KinematicBody2D

var speed = 100
var team = 1
onready var SM = get_node("StateMachine")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	SM.update_state()
	move()
	if Input.is_mouse_button_pressed(1): SM.set_state("attack")

func move():
	var mov = Vector2(0,0)
	if Input.is_action_pressed("ui_up"): mov.y = -1
	if Input.is_action_pressed("ui_down"): mov.y = 1
	if Input.is_action_pressed("ui_left"): mov.x = -1
	if Input.is_action_pressed("ui_right"): mov.x = 1
	SM.direction = mov.normalized()
	SM.destine = position + SM.direction * 100
	SM.look_dir = position.direction_to( get_global_mouse_position() )
	$circle_ind.look_at( get_global_mouse_position() )

func atack_with_anim():
	var dir = position.direction_to( get_global_mouse_position() )
	GC.attack( 1, position, SM.look_dir, SM.velocity )
