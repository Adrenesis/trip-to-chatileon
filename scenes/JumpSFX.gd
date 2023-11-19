extends AudioStreamPlayer

const JumpSFXs = [
	preload("res://audio/SFX/Jump23.wav"),
	preload("res://audio/SFX/Jump24.wav"),
	preload("res://audio/SFX/Jump31.wav")
]

var was_landing = false




func proxy_play():
	randomize()
	var sound_number = randi() % 3
	pitch_scale = 1.0 - (sound_number / 15.0)
	stream = JumpSFXs[sound_number]
	play()
