extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Button.connect("button_down",self,"restart_game")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func restart_game():
	get_tree().change_scene("res://scenes/Main.tscn")
