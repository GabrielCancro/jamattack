extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GC.PLAYER.connect("change_stats",self,"update_ui_stats")
	update_ui_stats()
	$UI/btn_pause.connect("button_down",self,"on_pause")
	$UI/Control_Pause/btn_continue.connect("button_down",self,"on_continue")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	for d in $Map/Deco.get_children():
		d.z_index = d.position.y
	GC.spawn()
	GC.spawn()
	GC.spawn()
	GC.spawn()
	GC.spawn()
	GC.spawn()
	$UI/Control_Pause.visible = true
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_ui_stats():
	$UI/lb_stats.text = "SALUD: "+str(GC.PLAYER.hp)

func on_pause():
	$UI/Control_Pause.visible = true
	get_tree().paused = true

func on_continue():
	$UI/Control_Pause.visible = false
	$UI/Control_Pause/btn_continue.text = "CONTINUAR"
	$UI/Control_Pause/Label.text = "PAUSADO"
	yield(get_tree().create_timer(.2),"timeout")
	get_tree().paused = false
