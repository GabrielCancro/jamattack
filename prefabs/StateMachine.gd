extends Node2D

var state
var destine = Vector2(0,0)
var velocity = Vector2(0,0)
var direction = Vector2(0,0)
var look_dir = Vector2(0,0)
var impulse = Vector2(0,0)

onready var GO = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	destine = GO.position
	set_state("idle")

func update_state():
	if(state!="attack"):
		if(GO.position.distance_to(destine)<10): set_state("idle")
		else: set_state("walk")
	
	if(impulse.length() != 0):
		GO.move_and_slide(impulse)
		impulse *= 0.9
		if impulse.length() < 10: impulse = Vector2.ZERO
		direction = Vector2.ZERO
		destine = GO.position
	else: if(GO.position.distance_to(destine)>=10):
		GO.move_and_slide(velocity)
	
	GO.z_index = GO.position.y
	velocity = direction * GO.speed
	if (look_dir.x > 0): GO.get_node("Sprite").scale.x = 1
	else: GO.get_node("Sprite").scale.x = -1
	
	if GO.modulate.r > 1: GO.modulate.r -= 0.5

func set_state(new_state):
	if state == new_state: return
	state = new_state
	GO.get_node("Anim").play(state)
	if state=="attack":
		yield(GO.get_node("Anim"),"animation_finished")
		set_state("idle")
