extends Node2D


var spleen = 0.0
const SPLEEN_GROWTH = 0.0125
const SPLEEN_THRESHOLD = 5.0
const SPLEEN_MUSIC_THRESHOLD = 15.0
const SPLEEN_INTENSITY = 1.0
var is_playing_stress_music = false

signal level_reset


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	spleen += SPLEEN_GROWTH
	if spleen >= SPLEEN_MUSIC_THRESHOLD and not is_playing_stress_music:
		get_parent().get_node("JukeBox").play_save_the_city()
		is_playing_stress_music = true
	if is_playing_stress_music:
		if spleen < SPLEEN_THRESHOLD:
			get_parent().get_node("JukeBox").play_deep_blue()
			is_playing_stress_music = false
		
	var colorrect = $foregroundDoodads/ColorRect
	colorrect.anchor_top = 0.0
	colorrect.anchor_bottom = 0.0
	colorrect.anchor_left = 0.0
	colorrect.anchor_right = 0.0
	colorrect.margin_top = -$Character.position.y*0.035+get_tree().get_root().get_size().y*0.5
#	colorrect.margin_top = -1000.0
	#print($deathplane.get_global_position().y)
	colorrect.margin_bottom = get_tree().get_root().get_size().y*1.2-$Character.get_global_position().y*0.5
	colorrect.margin_left = 0.0
	colorrect.margin_right = get_tree().get_root().get_size().x
	#colorrect = $foregroundDoodads/ColorRect2

	#print(-$Character.position.y*0.05, ", ", 0.0)
	##print($Horizon/deathplane2.get_global_transform())
	pass

func end_level():
	get_parent().end_game()

func teleport_to_spawn(object):
	emit_signal("level_reset")
	object.position = $SpawnPoint.position
