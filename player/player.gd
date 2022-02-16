extends KinematicBody2D


const BOOST_MULTIPLIER = 1.5
const GRAVITY = 150
const JUMP_SPEED = 3500
const SPEED = 750
const UP = Vector2(0, -1)
const WORLD_LIMIT = 8000

var hurt = false
var motion = Vector2(0, 0)

signal animate


func _ready ():
	add_to_group("Player")
	$PlayerReadySFX.play()
	yield(get_tree().create_timer(1), "timeout")
	$PlayerReadyParticles.queue_free()


func _physics_process (delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)


func apply_gravity ():
	if position.y > WORLD_LIMIT:
		if not $FallDownSFX.playing:
			$FallDownSFX.play()
		yield(get_tree().create_timer(2), "timeout")
		get_tree().call_group("Gamestate", "end_game")

	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY


func jump ():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED
		$JumpSFX.play()


func move ():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
		if is_on_floor():
			$Camera2D.position.x = -1000
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
		if is_on_floor():
			$Camera2D.position.x = 1000
	else:
		motion.x = 0


func animate ():
	emit_signal("animate", motion, hurt)


func hurt ():
	hurt = true
	position.y -= 1
	yield(get_tree(), "idle_frame")
	motion.y = -JUMP_SPEED
	$PainSFX.play()
	yield(get_tree().create_timer(1), "timeout")
	hurt = false


func boost ():
	position.y -= 1
	yield(get_tree(), "idle_frame")
	motion.y -= JUMP_SPEED * BOOST_MULTIPLIER
	$JumpPadSFX.play()


func win_game ():
	$AnimationPlayer.play("Vanish")
