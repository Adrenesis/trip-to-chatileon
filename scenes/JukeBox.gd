extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const DeepBlue = preload("res://audio/songs/Deep Blue.ogg")
const SaveTheCity = preload("res://audio/songs/Save the City.ogg")
const Penultimate = preload("res://audio/songs/Penultimate.ogg")



# Called when the node enters the scene tree for the first time.
func _ready():
	play_deep_blue()
	pass # Replace with function body.


func play_deep_blue():
	stream = DeepBlue
	reset_cursor()
	
func play_save_the_city():
	stream = SaveTheCity
	reset_cursor()

func play_penultimate():
	stream = Penultimate
	reset_cursor()

func reset_cursor():
	stop()
	seek(0.0)
	play(0.0)
