extends Area2D

var dir = Vector2(1,0)
var speed = 100
var vel_init = Vector2(0,0)
var ttl = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	position += dir * 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at( position + dir )
	position += (vel_init + dir * speed) * delta * ttl*2
	ttl *= .9
	modulate.a = ttl
	if ttl<=0: queue_free()
