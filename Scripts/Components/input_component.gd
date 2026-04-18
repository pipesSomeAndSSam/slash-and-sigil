# Component for managing Player Input for each player.
extends Node2D
class_name InputComponent

# Variables
@export var player_number: int

# Signals for movement
signal player_moved(movement: Vector2)

func _physics_process(delta: float) -> void:
	# Ensures only 2 players are available in the game.
	if player_number < 0 or player_number > 2:
		return
		
	# Get movement vector from player
	var p = "player%d_" % player_number
	var p_movement = Input.get_vector(
		p+"left",
		p+"right",
		p+"up",
		p+"down"
	)
	
	# Emit signal indicating the player has moved
	player_moved.emit(p_movement)
