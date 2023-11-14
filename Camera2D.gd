extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("screen_resized", self, "_on_screen_resized")
	pass # Replace with function body.

func _on_screen_resized():
	var size = get_tree().get_root().size 
	var min_ratio = 2000.0 /size.x
	zoom = Vector2(min_ratio, min_ratio) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
