extends Control

const SCROLL_SPEED = 2.0
const DARKEN_DELAY = 2.0

var credits_container
var preDelay = DARKEN_DELAY
var darkenDelay = 2.0
var scrollDelays = [ 1.0, 5.0, 5.0, 14.0, 3.0, 5.0 ]
var credits_done = false
var postDelay = 2.0
var scroll_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 0.8
	credits_container = $ColorRect2/VBoxContainer
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if preDelay > 0.0:
		preDelay -= delta
	else:
		if darkenDelay > 0.0:
			darkenDelay -= delta
			$ColorRect2.color.a +=delta / 3.0
		else:
			if credits_done:
				get_parent().go_back_to_starting_menu()
			var i = 0

				
			for scrollDelay in scrollDelays:
				if scrollDelay < 0.0:
					if i == scroll_counter:
						scroll_counter += 1
				else:
					if scroll_counter == i:
						scrollDelays[i] -= delta
				if scroll_counter >= scrollDelays.size():
					darkenDelay = DARKEN_DELAY
					credits_done = true
				i += 1
				
			if (scroll_counter % 2) == 1:
				credits_container.margin_top -= SCROLL_SPEED
				credits_container.margin_bottom -= SCROLL_SPEED
#	print(preDelay)
#	print(darkenDelay)
#	print(scrollDelays)
