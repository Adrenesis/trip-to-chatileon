extends AudioStreamPlayer

const WalkSFXs = [
	preload("res://audio/SFX/Walk.wav"),
	preload("res://audio/SFX/Walk1.wav"),
	preload("res://audio/SFX/Walk2.wav")
]

const LOOP_LENGTH = 0.27
var loop_frame = 0.0


func _process(delta):
	if not (get_parent().ANIM_STATE.WALKING == get_parent().anim_state):
		stop()
	else:
		loop_frame += delta
		if loop_frame > LOOP_LENGTH:
			loop_frame = 0.0
			stop()
			
			randomize()
			var sound_number = randi() % 3
			pitch_scale = 1.0 + (sound_number / 15.0)
			stream = WalkSFXs[sound_number]
			play()
	
