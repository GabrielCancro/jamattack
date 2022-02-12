extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.connect("button_down",self,"start_game")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func start_game():
	get_tree().change_scene("res://scenes/Game.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
