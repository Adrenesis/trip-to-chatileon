extends Node



var level = null
const Level = preload("res://scenes/Level.tscn")
const PauseMenu = preload("res://scenes/PauseMenu.tscn")
const SettingsMenu = preload("res://scenes/SettingsMenu.tscn")
const StartingMenu = preload("res://scenes/StartingMenu.tscn")
const Credits = preload("res://scenes/Credits.tscn")
var pause_menu = null
var settings_menu = null
var starting_menu = null
var credits = null
var is_paused = false
var is_in_settings = false
var pause_texture = null

func _ready():
	if OS.is_debug_build():
		set_master_volume(20.0)
	starting_menu = StartingMenu.instance()
	add_child(starting_menu)
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not is_paused:
		is_paused = true
		level = $Level
		remove_child(level)
		pause_menu = PauseMenu.instance()
		add_child(pause_menu)
		pause_texture = ImageTexture.new()
		var img = Image.new()
		var previous_image = get_tree().get_root().get_texture().get_data()
		previous_image.flip_y()
		pause_texture.create_from_image(previous_image)
#		print("a")
#		yield(VisualServer, "frame_post_draw")
#		print("a")
#		img = tex.get_data()
		
		$PauseMenu/TextureRect.texture = pause_texture


	elif Input.is_action_just_pressed("ui_cancel") and is_paused and is_in_settings:
		go_back_from_settings()
	elif Input.is_action_just_pressed("ui_cancel") and is_paused and not is_in_settings:
		resume_game()

func go_to_settings_menu():
	is_in_settings = true
	remove_child(pause_menu)
	pause_menu.queue_free()
	pause_menu = null
	settings_menu = SettingsMenu.instance()
	add_child(settings_menu)
	$SettingsMenu/TextureRect.texture = pause_texture
	
func go_back_from_settings():
	is_in_settings = false
	remove_child(settings_menu)
	settings_menu.queue_free()
	settings_menu = null
	pause_menu = PauseMenu.instance()
	add_child(pause_menu)
	$PauseMenu/TextureRect.texture = pause_texture
	
func go_back_to_starting_menu():
	is_paused = false
	if (pause_menu != null):
		if (is_instance_valid(pause_menu)):
			remove_child(pause_menu)
			pause_menu.queue_free()
			pause_menu = null
	if (level != null):
		if (is_instance_valid(level)):
			level.queue_free()
			level = null
	if (credits != null):
		if (is_instance_valid(credits)):
			remove_child(credits)
			credits.queue_free()
			credits = null
	$JukeBox.play_deep_blue()
	starting_menu = StartingMenu.instance()
	add_child(starting_menu)

func resume_game():
	is_paused = false
	remove_child(pause_menu)
	pause_menu.queue_free()
	pause_menu = null
	add_child(level)

func start_game():
	is_paused = false
	remove_child(starting_menu)
	starting_menu.queue_free()
	starting_menu = null
	level = Level.instance()
	add_child(level)

func end_game():
	$JukeBox.stop()
	$JukeBox.play_penultimate()
	remove_child(level)
	level.queue_free()
	level = null
	credits = Credits.instance()
	add_child(credits)
	

func quit_game():
	get_tree().quit()

func set_master_volume(value):
	AudioServer.set_bus_volume_db(0, log(value)*20.0-88.0)
	
func set_sfx_volume(value):
	AudioServer.set_bus_volume_db(1, log(value)*20.0-88.0)
	
func set_music_volume(value):
	AudioServer.set_bus_volume_db(2, log(value)*20.0-88.0)
