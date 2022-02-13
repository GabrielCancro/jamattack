extends KinematicBody2D

var speed = 100
var team = 1
var hp = 5
var attack = 1
var slide_charge = 1

signal change_stats
onready var SM = get_node("StateMachine")

# Called when the node enters the scene tree for the first time.
func _ready():
	GC.connect("low_update",self,"low_update")
	$lb_slide.text = ""

func low_update():
	if(slide_charge<1): 
		slide_charge += .09
		$lb_slide.text = str( floor(slide_charge*100) ) + "%"
		if(slide_charge>=1): $lb_slide.text = ""
	
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
	if Input.is_action_pressed("ui_select") && slide_charge>=1: 
		slide_charge = 0
		SM.impulse = SM.direction * 500
		GC.GAME.get_node("SFX/sfx_dash").play()
	SM.destine = position + SM.direction * 100
	
	SM.look_dir = position.direction_to( get_global_mouse_position() )
	$circle_ind.look_at( get_global_mouse_position() )

func atack_with_anim():
	var dir = position.direction_to( get_global_mouse_position() )
	GC.attack( 1, position, SM.look_dir, SM.velocity + SM.impulse/2 )

func hit(dam):
	hp -= dam
	GC.blood(position)
	if hp<= 0: GC.end_game()
	emit_signal("change_stats")
