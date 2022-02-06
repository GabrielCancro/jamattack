extends KinematicBody2D

var vel = 100
var velocity = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	move()

func move():
	var mov = Vector2(0,0)
	if Input.is_action_pressed("ui_up"): mov.y = -1
	if Input.is_action_pressed("ui_down"): mov.y = 1
	if Input.is_action_pressed("ui_left"): mov.x = -1
	if Input.is_action_pressed("ui_right"): mov.x = 1
	mov = mov.normalized()
	velocity = mov * vel
	move_and_slide(velocity)
	z_index = position.y
	$Sprite/Sprite.flip_h = (get_global_mouse_position().x < position.x)
	$circle_ind.look_at( get_global_mouse_position() )
	if(mov.length()==0): $Anim.play("idle")
	else: $Anim.play("walk")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			atack()

func atack():
	var dir = position.direction_to( get_global_mouse_position() )
	GC.attack( 1, position, dir, velocity )
	print("atack")
