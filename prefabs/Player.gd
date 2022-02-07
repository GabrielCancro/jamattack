extends KinematicBody2D

var vel = 100
var velocity = Vector2(0,0)
var state
var mov = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_state("idle")

func _process(delta):
	
	if(state!="attack"):
		if(mov.length()==0): set_state("idle")
		else: set_state("walk")
		if Input.is_mouse_button_pressed(1): set_state("attack")
	move()

func move():
	mov = Vector2(0,0)
	if Input.is_action_pressed("ui_up"): mov.y = -1
	if Input.is_action_pressed("ui_down"): mov.y = 1
	if Input.is_action_pressed("ui_left"): mov.x = -1
	if Input.is_action_pressed("ui_right"): mov.x = 1
	mov = mov.normalized()
	velocity = mov * vel
	move_and_slide(velocity)
	z_index = position.y
	$Sprite.scale.x = 1
	if (get_global_mouse_position().x < position.x): $Sprite.scale.x = -1
	$circle_ind.look_at( get_global_mouse_position() )

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			pass

func atack_with_anim():
	var dir = position.direction_to( get_global_mouse_position() )
	GC.attack( 1, position, dir, velocity )
	print("atack")

func set_state(new_state):
	print(state)
	if state == new_state: return
	state = new_state
	$Anim.play(state)
	if state=="attack":
		yield($Anim,"animation_finished")
		set_state("idle")
