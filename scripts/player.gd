extends CharacterBody2D

@export var speed = 800.0
@export var stopping_distance = 10.0
@export var health = 3


var destroyed = false
var laser_one = preload("res://components/laser_one.tscn")
var laser_two = preload("res://components/laser_two.tscn")
var laser_three = preload("res://components/laser_three.tscn")

var can_shoot = true
var power_up_boost = 0

func _ready() -> void:
	$AnimationPlayerBoom.play("idle")
	$AnimationPlayerPowerUp.play("idle")
	$AnimationPlayerHurt.play("idle")

func _physics_process(_delta: float) -> void:
	if Global.game_on == true and Global.game_over == false:
		turn_on_playerClass_body()
		visible = true

		if Input.is_action_pressed("left_click"):
			var mouse_position = get_global_mouse_position()
			var distance_to_mouse = global_position.distance_to(mouse_position)
			if distance_to_mouse > stopping_distance:
				var direction = (mouse_position - global_position).normalized()
				velocity = direction * speed
			else:
				velocity = Vector2.ZERO
			move_and_slide()
			if can_shoot == true:
				shoot_laser()
		else:
			velocity = Vector2.ZERO
			move_and_slide()
	if health <= 0 and destroyed == false:
		Global.game_over = true
		speed = 0
		$playerClass.visible = false
		$AudioStreamPlayer2DGameOver.play()
		$AnimationPlayerBoom.play("boom")
		destroyed = true

func turn_on_playerClass_body():
	if Global.choosen_class == 1:
		$playerClass/knight.visible = true
		$playerClass/mage.visible = false
		$playerClass/marksman.visible = false
	elif Global.choosen_class == 2:
		$playerClass/knight.visible = false
		$playerClass/mage.visible = true
		$playerClass/marksman.visible = false
	elif Global.choosen_class == 3:
		$playerClass/knight.visible = false
		$playerClass/mage.visible = false
		$playerClass/marksman.visible = true
	
func shoot_laser():
	var new_laser
	if Global.choosen_class == 1:
		new_laser = laser_one.instantiate()
		add_sibling(new_laser)
		$TimerToShoot.wait_time = 0.1 - power_up_boost
	elif Global.choosen_class == 2:
		new_laser = laser_two.instantiate()
		add_sibling(new_laser)
		$TimerToShoot.wait_time = 0.1 - power_up_boost
	elif Global.choosen_class == 3:
		new_laser = laser_three.instantiate()
		add_sibling(new_laser)
		$TimerToShoot.wait_time = 0.1 - power_up_boost
	new_laser.global_position = $point.global_position
	can_shoot = false
	$AudioStreamPlayer2DLaser.play()
	$TimerToShoot.start()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		health -= 1
		$AnimationPlayerHurt.play("hurt")
		if health <=1:
			$AudioStreamPlayer2DHit.play()
		_on_timer_power_up_timeout()
	if area.is_in_group("power_up"):
		area.get_parent().queue_free()
		power_up_boost = 0.4
		$AnimationPlayerPowerUp.play("power_up")
		$TimerPowerUp.start()

func _on_timer_power_up_timeout() -> void:
	power_up_boost = 0 
	$AnimationPlayerPowerUp.play("idle")
	
func _on_timer_to_shoot_timeout() -> void:
	can_shoot = true
