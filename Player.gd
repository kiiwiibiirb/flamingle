extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 22.5
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -600
var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
	else:
		friction = true
		motion.x = lerp(motion.x, 0, 0.2)
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	motion = move_and_slide(motion, UP)
	pass