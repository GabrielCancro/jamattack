extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"start_game")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Instructions.visible_characters = 0

func start_game():
	$Button.disconnect("button_down",self,"start_game")
	$sfx_button.play()
	yield(get_tree().create_timer(1),"timeout")
	get_tree().change_scene("res://scenes/Game.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GC.intro_time += delta * 25
	$Instructions.visible_characters = GC.intro_time
	if GC.intro_time>200:
		$Button.visible = true
		set_process(false)
