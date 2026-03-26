extends Sprite2D

@export var laser: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	var new_laser = laser.instantiate()
	add_child(new_laser)
	new_laser.global_position = $point.global_position

	
