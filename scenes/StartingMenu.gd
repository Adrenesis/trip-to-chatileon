extends Control




func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_parent().quit_game()
	if (
		Input.is_action_just_pressed("ui_accept")
			or
		Input.is_action_just_pressed("ui_select")
			or
		Input.is_action_just_pressed("ui_left")
			or
		Input.is_action_just_pressed("ui_right")
			or
		Input.is_action_just_pressed("ui_up")
			or
		Input.is_action_just_pressed("ui_down")
	):
		get_parent().start_game()
	anchor_left = 0.0
	anchor_top = 0.0
	anchor_right = 1.0
	anchor_bottom = 1.0
	margin_left = 0.0
	margin_top = 0.0
	margin_right = 0.0
	margin_bottom = 0.0
	margin_bottom = 0.0
	
		

