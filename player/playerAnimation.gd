extends AnimatedSprite


func _on_Player_animate (motion, hurt):
	if motion.y < 0:
		if hurt:
			play("hurt")
		else:
			play("jump")
	elif motion.x > 0:
		play("walk")
		flip_h = false
	elif motion.x < 0:
		play("walk")
		flip_h = true
	else:
		play("idle")
