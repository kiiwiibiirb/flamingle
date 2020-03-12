extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 22.5
const ACCELERATION = 50
const MAX_SPEED = 300
const JUMP_HEIGHT = -750
var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Run")
	elif Input.is_action_pressed("left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run")
	else:
		$AnimatedSprite.play("Idle")
		friction = true
		motion.x = lerp(motion.x, 0, 0.2)
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			$AnimatedSprite.play("Idle")
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
