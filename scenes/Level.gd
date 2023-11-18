extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
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
