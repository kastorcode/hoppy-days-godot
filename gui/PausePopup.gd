extends CanvasLayer


func _process (delta):
	if Input.is_action_just_released("pause_game"):
		pause_game()
	if Input.is_action_just_released("restart_scene"):
		restart_scene()


func pause_game ():
	if get_tree().paused:
		get_tree().paused = false
		$Popup.hide()
	else:
		get_tree().paused = true
		$Popup.show()


func restart_scene ():
	get_tree().paused = false
	get_tree().reload_current_scene()
