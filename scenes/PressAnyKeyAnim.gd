extends TextureRect
var is_forward = true
var blink_frame = 0.0
const ANIMATION_SPEED = 0.06

func _process(delta):
	if is_forward:
		blink_frame += ANIMATION_SPEED
	else:
		blink_frame -= ANIMATION_SPEED
	self.modulate.a = blink_frame
	if blink_frame > 1.0:
		blink_frame = 0.99
		is_forward = false
	elif blink_frame < 0.0:
		blink_frame = 0.01
		is_forward = true
