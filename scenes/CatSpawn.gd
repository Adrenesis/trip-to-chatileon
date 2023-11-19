extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Cat = preload("res://scenes/Cat.tscn")
const BigCat = preload("res://scenes/BigCat.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_parent().connect("level_reset", self, "_on_level_reset")
	visible = false
	print("catspawn ready")
	randomize()
	var cat_number = int(floor(rand_range(0.0, 11.99999)))
	print(cat_number)
	if cat_number in [ 0, 1, 2, 3, 4, 5]:
		var cat = Cat.instance()
		get_parent().call_deferred("add_child", cat)
		cat.frame = cat_number * 3.0
		cat.cat_number = cat_number
		cat.position = self.position
	elif cat_number in [ 6, 7, 8, 9, 10, 11]:
		var cat = BigCat.instance()
		get_parent().call_deferred("add_child", cat)
		cat.position = self.position
		cat.cat_number = cat_number
		cat.frame = (cat_number-6) * 3.0
	pass # Replace with function body.


func _on_level_reset():
	_ready()
