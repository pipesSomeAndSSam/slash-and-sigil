extends Node2D
class_name InputComponent

# Signals for movement
signal player1_moved(movement: Vector2)
signal player2_moved(movement: Vector2)

func _physics_process(delta: float) -> void:
	# Get movement vector and emit through each player
	var p1_movement = Input.get_vector(
		"player1_left", 
		"player1_right", 
		"player1_up", 
		"player1_down")
	var p2_movement = Input.get_vector(
		"player2_left",
		"player2_right",
		"player2_up", 
		"player2_down")
	
	player1_moved.emit(p1_movement)
	player2_moved.emit(p2_movement)
