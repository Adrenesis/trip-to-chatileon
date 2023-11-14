extends Node2D


const SPRITESHEET_BREATHING = preload("res://graphics/breathing_sprite_frise.png")
const SPRITESHEET_WALKING = preload("res://graphics/perso-anim-gamejamhauteur-white.png")
const SPRITESHEET_JUMPING = preload("res://graphics/character-jump.png")
const SPRITESHEET_FALLING = preload("res://graphics/character-fall.png")
const SPRITESHEET_LANDING = preload("res://graphics/character-land.png")


const GRAVITY = 3.0
const MAX_SPEED_X = 14.0
const ACCEL_X_WALK = 1.5
const WALK_HFRAMES = 7
const WALK_VFRAMES = 2
const JUMP_HFRAMES = 3
const JUMP_VFRAMES = 1
const IDLE_HFRAMES = 5
const IDLE_VFRAMES = 1
const FALL_HFRAMES = 3
const FALL_VFRAMES = 1
const LAND_HFRAMES = 2
const LAND_VFRAMES = 1
const WALK_ANIMATION_SPEED = 0.33
const JUMP_ANIMATION_SPEED = 0.33
const FALL_ANIMATION_SPEED = 0.33
const LAND_ANIMATION_SPEED = 0.6
const IDLE_ANIMATION_SPEED = 0.1
const IDLE_X_DAMPING = 1.5
const IDLE_STOP_THESHOLD = 0.7
const CHARACTER_HEIGHT = 10
const CHARACTER_WIDTH = 62
const JUMP_ACCEL = 50.0
const SPEED_X_JUMP_ACCEL_MULTIPLIER = 0.2
const IDLE_CHARGE_SPEED = 5.0
const IDLE_CHARGE_MAX = 15.0
var speed = Vector2(0.0, 0.0)
var walk_frame_float = 0.0
var idle_frame_float = 0.0
var jump_frame_float = 0.0
var fall_frame_float = 0.0
var land_frame_float = 0.0
var airborn = true
var landing = false
var idle_charge = 0.0
var anim_state = ANIM_STATE.IDLE
var frame_count = 0
enum ANIM_STATE {
	LANDING,
	FALLING,
	JUMPING,
	WALKING,
	IDLE
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2DStayGround.connect("area_exited", self, "_on_ground_leaved")
	$Area2DTouchGround.connect("area_entered", self, "_on_ground_touched")
	$Area2DBoundBox.connect("area_entered", self, "_on_wall_touched")
	Engine.time_scale = 0.8
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	frame_count += 1
	if Input.is_action_pressed("ui_left"):
		if not airborn and not landing:
			anim_state = ANIM_STATE.WALKING
			walk_frame_float += WALK_ANIMATION_SPEED * delta * 60.0
			print("[", frame_count, "] walk")
		speed.x -= ACCEL_X_WALK * delta * 60.0
		$Sprite.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		if not airborn and not landing:
			anim_state = ANIM_STATE.WALKING
			walk_frame_float += WALK_ANIMATION_SPEED * delta * 60.0
		speed.x += ACCEL_X_WALK * delta * 60.0
		$Sprite.flip_h = false
	else:
		speed.x /= IDLE_X_DAMPING
		if (speed.x < IDLE_STOP_THESHOLD) and (speed.x > -IDLE_STOP_THESHOLD):
			if not airborn and not landing:
				anim_state = ANIM_STATE.IDLE
			speed.x = 0.0
	if Input.is_action_just_pressed("ui_up") and not airborn:
		print("[", frame_count, "] jump")
		jump_frame_float = 0.0
		anim_state = ANIM_STATE.JUMPING
		speed.y = -JUMP_ACCEL + abs(speed.x) * SPEED_X_JUMP_ACCEL_MULTIPLIER * delta * 60.0
		speed.x *= 1.1 * delta * 60.0
		airborn = true
	if speed.x < -MAX_SPEED_X:
		speed.x = -MAX_SPEED_X * delta * 60.0
	elif speed.x > MAX_SPEED_X:
		speed.x = MAX_SPEED_X * delta * 60.0
	if airborn:
		speed.y += GRAVITY * delta * 60.0
		if speed.y > 0.0:
			if anim_state != ANIM_STATE.FALLING:
				fall_frame_float = 0.0
			anim_state = ANIM_STATE.FALLING
		else:
			if anim_state != ANIM_STATE.JUMPING:
				jump_frame_float = 0.0
			anim_state = ANIM_STATE.JUMPING
	else:
		speed.y = 0
		self.position.y = $RayCast2D.get_collision_point().y - CHARACTER_HEIGHT/2.0
		#print("[", frame_count, "] collision_point", $RayCast2D.get_collision_point())
	self.position += speed * delta * 60.0
	
	if ANIM_STATE.IDLE == anim_state:
		change_spritesheet(SPRITESHEET_BREATHING, IDLE_HFRAMES, IDLE_VFRAMES)
		idle_charge += IDLE_CHARGE_SPEED
		
		if idle_charge < IDLE_CHARGE_MAX:
			idle_frame_float += IDLE_ANIMATION_SPEED
		else:
			idle_frame_float += IDLE_ANIMATION_SPEED / 2.0
		if floor(idle_frame_float) > 4:
			$Sprite.frame = 0
			idle_frame_float = 0.0
		else:
			$Sprite.frame = floor(idle_frame_float)
	elif ANIM_STATE.WALKING == anim_state:
		change_spritesheet(SPRITESHEET_WALKING, WALK_HFRAMES, WALK_VFRAMES)
		idle_charge = 0.0
		$Sprite.frame = floor(walk_frame_float)
		if $Sprite.frame > 10:
			$Sprite.frame = 0
			walk_frame_float = 0
	elif ANIM_STATE.JUMPING == anim_state:
		change_spritesheet(SPRITESHEET_JUMPING, JUMP_HFRAMES, JUMP_VFRAMES)
		jump_frame_float += JUMP_ANIMATION_SPEED * delta * 60.0
		if floor(jump_frame_float) > 2:
			jump_frame_float = 2.0
		else:
			$Sprite.frame = floor(jump_frame_float)
	elif ANIM_STATE.FALLING == anim_state:
		change_spritesheet(SPRITESHEET_FALLING, FALL_HFRAMES, FALL_VFRAMES)
		fall_frame_float += FALL_ANIMATION_SPEED * delta * 60.0
		if floor(fall_frame_float) > 2:
			fall_frame_float = 2.0
		else:
			$Sprite.frame = floor(fall_frame_float)
	elif ANIM_STATE.LANDING == anim_state:
		change_spritesheet(SPRITESHEET_LANDING, LAND_HFRAMES, LAND_VFRAMES)
		land_frame_float += LAND_ANIMATION_SPEED * delta * 60.0
		if land_frame_float > 2.1:
			landing = false
		else:
			$Sprite.frame = floor(land_frame_float)

func change_spritesheet(spritesheet, hframes, vframes):
	$Sprite.texture = spritesheet
	$Sprite.hframes = hframes
	$Sprite.vframes = vframes
		

func _on_ground_touched(area):
	#print("[", frame_count, "] touched ", area)
	if speed.y > 0.0: 
#		self.position.y = (
#			area.get_children()[0].global_position.y - 
#			area.get_children()[0].shape.get_extents().y
#		) - CHARACTER_HEIGHT
		airborn = false
		landing = true
		anim_state = ANIM_STATE.LANDING
		land_frame_float = 0.0

func _on_wall_touched(area):
	print("[", frame_count, "] touched ", area)
	var wall_shape = area.get_children()[0]
	var wall_scale = area.get_parent().scale
	var wall_position = area.get_parent().get_global_position()
	var self_shape = $Area2DBoundBox/CollisionShape2D
	var pos = self.get_global_position()
	if pos.x > wall_position.x:
		if speed.x < 0.0:
			speed.x = 0.0
		self.position.x = wall_position.x + (wall_shape.shape.extents.x/2.0) * wall_scale.x + CHARACTER_WIDTH/2.0
	elif pos.x < wall_position.x:
		if speed.x > 0.0:
			speed.x = 0.0
		self.position.x = wall_position.x - ((wall_shape.shape.extents.x/2.0) * wall_scale.x + CHARACTER_WIDTH/2.0)
	

func _on_ground_leaved(area: Area2D):
	print("[", frame_count, "] leaved: ", area)
	airborn = true
