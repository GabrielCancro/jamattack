extends Node2D


# Declare member variables here. Examples:
var aDir = 0
var destine
var dir = Vector2(0,0)
var speed = 20

var DEADS
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	GC.connect("low_update",self,"low_update")
	destine = position
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Sprite.modulate.a > .30: aDir = -.001
	if $Sprite.modulate.a < .10: aDir = .001
	$Sprite.modulate.a += aDir
	$Sprite.scale.x += aDir / 10
	$Sprite.scale.y -= aDir / 15
	z_index = position.y
	$Sprite.flip_h = dir.x>0
	position += dir * delta * speed

func low_update():
	if position.distance_to(destine)<20:
		destine = Vector2( rand_range(150,900), rand_range(80,520))
		dir = position.direction_to(destine)
	speed = 20
	for head in GC.GAME.get_node("Deads").get_children():
		if head.position.distance_to(position)<150:
			destine = head.position
			speed = 40
			dir = position.direction_to(destine)
			if head.position.distance_to(position)<30:
				GC.blood(head.position)
				GC.blood(head.position)
				head.queue_free()
