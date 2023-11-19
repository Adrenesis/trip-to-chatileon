extends AudioStreamPlayer


const WalkSFXs = [
	preload("res://audio/SFX/Walk.wav"),
	preload("res://audio/SFX/Walk1.wav"),
	preload("res://audio/SFX/Walk2.wav")
]

func proxy_play():
	stop()
	randomize()
	var sound_number = randi() % 3
	pitch_scale = 1.0 - (sound_number / 15.0)
	stream = WalkSFXs[sound_number]
	play()


	
