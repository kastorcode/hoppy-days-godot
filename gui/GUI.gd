extends CanvasLayer


func update_GUI (lives_left, coins):
	$Control/TextureRect/HBoxContainer/LifeCount.text = str(lives_left)
	$Control/TextureRect/HBoxContainer/CoinCount.text = str(coins)


func update_timer ():
	global.game_time.seconds += 1
	if global.game_time.seconds == 60:
		global.game_time.seconds = 0
		global.game_time.minutes += 1
	$Control/TimerText.text = str(global.game_time.minutes) + ':' + str(global.game_time.seconds)


func _on_Timer_timeout ():
	update_timer()
