extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	for d in $Map/Deco.get_children():
		d.z_index = d.position.y
	GC.spawn()
	GC.spawn()
	GC.spawn()
	GC.spawn()
	GC.spawn()
	GC.spawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Cursor.position = get_global_mouse_position()

