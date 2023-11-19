extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuPanel/VBoxContainer/ResumeButton.connect("pressed", get_parent(), "resume_game")
	$MenuPanel/VBoxContainer/SettingsButton.connect("pressed", get_parent(), "go_to_settings_menu")
	$MenuPanel/VBoxContainer/StartingMenuButton.connect("pressed", get_parent(), "go_back_to_starting_menu")
	$MenuPanel/VBoxContainer/QuitButton.connect("pressed", get_parent(), "quit_game")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
