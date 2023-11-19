extends Sprite

const ANIMATION_SPEED = 0.1
var animation_forward = true
var cat_number = 6
var cat_frame = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animation_forward:
		cat_frame += ANIMATION_SPEED
	else:
		cat_frame += -ANIMATION_SPEED
	
	if cat_frame >= 3.0:
		animation_forward = false
		cat_frame = 2.99
	elif cat_frame <= 0:
		animation_forward = true
		cat_frame = 0.01
	frame = (cat_number % 6) * 3 + floor(cat_frame)
	pass

#func touched(character):
	#interpolate
	
