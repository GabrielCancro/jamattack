extends Area2D

var dir = Vector2(1,0)
var speed = 100
var vel_init = Vector2(0,0)
var ttl = 1
var own = 0
var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	position += dir * 10
	connect("body_entered",self,"on_enter_body")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at( position + dir )
	position += (vel_init + dir * speed) * delta * ttl*2
	ttl *= .92
	modulate.a = ttl
	if ttl<=.1: queue_free()

func on_enter_body(body):
	if !body.get("team"): return
	if body.team == own: return
	if body.has_method("hit") : 
		body.hit(1)
		GC.GAME.get_node("SFX/sfx_hit1").play()
		body.modulate.r = 10
		body.SM.impulse = dir*200
