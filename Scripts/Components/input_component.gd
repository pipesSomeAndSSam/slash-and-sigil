# Component for managing Player Input for each player.
extends Node2D
class_name InputComponent

# Variables
@export var player_number: int
@onready var player_number_string := "player%d_" % player_number

# Signals for button presses
signal player_moved(movement: Vector2)
signal attack_pressed
signal skill1_pressed
signal skill2_pressed

func _physics_process(delta: float) -> void:
	# Ensures only 2 players are available in the game.
	if player_number < 0 or player_number > 2:
		return
		
	# Get movement vector from player
	var p_movement = Input.get_vector(
		player_number_string + "left",
		player_number_string + "right",
		player_number_string + "up",
		player_number_string + "down"
	)
	
	# Emit signal indicating the player has moved
	player_moved.emit(p_movement)

func _input(event: InputEvent) -> void:
	# Emit signals for when attack and skill keys are pressed
	if event.is_action_pressed(player_number_string + "attack"):
		attack_pressed.emit()
	
	elif event.is_action_pressed(player_number_string + "skill1"):
		skill1_pressed.emit()
		
	elif event.is_action_pressed(player_number_string + "skill2"):
		skill2_pressed.emit()
