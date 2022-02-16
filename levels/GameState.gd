extends Node2D


var coins = 0
var lives = 3
var target_number_of_coins = 50


func _ready ():
	global.reset_values()
	add_to_group("Gamestate")
	update_GUI()


func hurt ():
	lives -= 1
	$Player.hurt()
	update_GUI()
	if lives < 0:
		end_game()


func update_GUI ():
	get_tree().call_group("GUI", "update_GUI", lives, coins)


func coin_up ():
	coins += 1
	update_GUI()
	var multiple_of_coins = (coins % target_number_of_coins) == 0
	if multiple_of_coins:
		life_up()


func life_up ():
	lives += 1
	update_GUI()
	$LifeUpSFX.play()


func end_game ():
	get_tree().change_scene("res://levels/GameOver.tscn")


func win_game ():
	if $Coins.get_child_count() == 0:
		$GUI/Timer.stop()
		get_tree().call_group("Player", "win_game")
		yield(get_tree().create_timer(3), "timeout")
		get_tree().change_scene("res://levels/Victory.tscn")
	elif not $InPortalSFX.playing:
		$InPortalSFX.play()
