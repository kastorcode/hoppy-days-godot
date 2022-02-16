extends Control


func _ready ():
	$CenterContainer/VBoxContainer/TimeSpentContainer/Minutes.text = str(global.game_time.minutes) + ' minute(s)'
	$CenterContainer/VBoxContainer/TimeSpentContainer/Seconds.text = str(global.game_time.seconds) + ' second(s)'


func _on_RestartButton_pressed ():
	get_tree().change_scene("res://levels/Level1.tscn")
