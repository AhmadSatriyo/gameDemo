extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/inGameScreen.visible = false
	$CanvasLayer/gameOverScreen.visible = false

func _on_button_play_pressed():
	$CanvasLayer/startScreen.visible = false
	$CanvasLayer/chooseScreen.visible = true
	$click.play()

func _on_button_knight_pressed():
	Global.choosen_class = 1
	$CanvasLayer/chooseScreen/playerClass/mage.visible = false
	$CanvasLayer/chooseScreen/playerClass/knight.visible = true
	$CanvasLayer/chooseScreen/playerClass/marksman.visible = false
	$click.play()

func _on_button_mage_pressed() -> void:
	Global.choosen_class = 2
	$CanvasLayer/chooseScreen/playerClass/mage.visible = true
	$CanvasLayer/chooseScreen/playerClass/knight.visible = false
	$CanvasLayer/chooseScreen/playerClass/marksman.visible = false
	$click.play()

func _on_button_marksman_pressed() -> void:
	Global.choosen_class = 3
	$CanvasLayer/chooseScreen/playerClass/mage.visible = false
	$CanvasLayer/chooseScreen/playerClass/knight.visible = false
	$CanvasLayer/chooseScreen/playerClass/marksman.visible = true
	$click.play()

func _on_button_choose_pressed() -> void:
	Global.game_on = true
	$click.play()
	$CanvasLayer/chooseScreen.visible = false
	$CanvasLayer/inGameScreen.visible = true
	$CanvasLayer/chooseScreen.queue_free()

func _on_button_mute_pressed() -> void:
	$click.play()
	if Global.mute == false:
		$click.play()
		Global.mute = true
		$CanvasLayer/inGameScreen/buttonMute/LabelOff.visible = true
		$CanvasLayer/inGameScreen/buttonMute/LabelOn.visible = false
	else:
		$click.play()
		Global.mute = false
		$CanvasLayer/inGameScreen/buttonMute/LabelOff.visible = false
		$CanvasLayer/inGameScreen/buttonMute/LabelOn.visible = true

func _on_button_menu_pressed() -> void:
	Global.resetValue()
	get_tree().reload_current_scene()
	$click.play()

func _process(_delta) -> void:
	if Global.game_over == true:
		$CanvasLayer/inGameScreen.visible = false
		$CanvasLayer/gameOverScreen.visible = true
		$CanvasLayer/gameOverScreen/LabelScoreAkhir.text = "Score: " + str(Global.score)
	else:
		$CanvasLayer/inGameScreen/LabelScoreAwal.text = str(Global.score)


