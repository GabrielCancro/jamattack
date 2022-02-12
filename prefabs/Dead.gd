extends Sprite

var ttl = 10

func _ready():
	pass # Replace with function body.

func _process(delta):
	ttl -= delta
	if ttl <= 0:
		var EN = GC.spawn()
		EN.get_node("Sprite/body").texture = preload("res://assets/ene3.png")
		EN.speed += 20
		EN.position = position
		queue_free()
