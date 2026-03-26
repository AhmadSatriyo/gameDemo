extends Node

var game_over = false
var game_on = false
var score = 0
var choosen_class = 1
var mute = false

func resetValue():
	game_over = false
	game_on = false
	score = 0
	choosen_class = 1
	mute = false

func _process(_delta):
	if mute == true:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 0)




	
