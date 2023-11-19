extends Sprite

var is_forward = true
var is_first_frame = true
const ANIMATION_SPEED = 0.06
var anim_frame = 0.0
var original_position = null
var original_scale = null

func _process(delta):
	if is_first_frame:
		original_position = position
		original_scale = scale
		is_first_frame = false
	
	var level = get_parent().get_parent()
	var spleen = level.spleen
	var spleen_intensity = level.SPLEEN_INTENSITY
	var spleen_threshold = level.SPLEEN_THRESHOLD
	spleen = spleen - spleen_threshold
	
	spleen *= spleen_intensity
	#print(spleen)
	if spleen > 0.0:
		scale = Vector2(original_scale.x + spleen, original_scale.y + spleen)
	else:
		scale = original_scale
	if is_forward:
		anim_frame += ANIMATION_SPEED
	else:
		anim_frame -= ANIMATION_SPEED
	position.y = original_position.y + anim_frame*20.0
	if anim_frame > 1.0:
		anim_frame = 0.99
		is_forward = false
	elif anim_frame < 0.0:
		anim_frame = 0.01
		is_forward = true

	


