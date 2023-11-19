extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuPanel/HBoxContainer/VBoxContainer2/MasterSlider.connect("value_changed", get_parent(), "set_master_volume")
	$MenuPanel/HBoxContainer/VBoxContainer2/SFXSlider.connect("value_changed", get_parent(), "set_sfx_volume")
	$MenuPanel/HBoxContainer/VBoxContainer2/MusicSlider.connect("value_changed", get_parent(), "set_music_volume")
	$MenuPanel/HBoxContainer/VBoxContainer2/ReturnButton.connect("pressed", get_parent(), "go_back_from_settings")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
