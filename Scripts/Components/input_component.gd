# Component for managing Player Input for each player.
extends Node2D
class_name InputComponent

#region Declarables
# Variables
@export var player_number: int

# Constants for Directions
const LEFT : String = "left"
const RIGHT : String = "right"
const UP : String = "up"
const DOWN : String = "down"

# Constants for Directions 
const ATTACK : String = "attack"
const SKILL1 : String = "skill1"
const SKILL2 : String = "skill2"

# Signals for button presses
signal player_moved(movement: Vector2)
signal attack_pressed
signal skill1_pressed
signal skill2_pressed
#endregion

func _physics_process(delta: float) -> void:
	# Ensures only 2 players are available in the game.
	if player_number < 0 or player_number > 2:
		return
		
	# Get movement vector from player
	var p_movement = Input.get_vector(
		Strings.PLAYER_INPUT_MOVEMENT_MAP(player_number, LEFT),
		Strings.PLAYER_INPUT_MOVEMENT_MAP(player_number, RIGHT),
		Strings.PLAYER_INPUT_MOVEMENT_MAP(player_number, UP),
		Strings.PLAYER_INPUT_MOVEMENT_MAP(player_number, DOWN)
	)
	
	# Emit signal indicating the player has moved
	player_moved.emit(p_movement)

func _input(event: InputEvent) -> void:
	# Emit signals for when attack and skill keys are pressed
	if event.is_action_pressed(
		Strings.PLAYER_INPUT_ACTION_MAP(player_number, ATTACK)
	):
		attack_pressed.emit()
	
	elif event.is_action_pressed(
		Strings.PLAYER_INPUT_ACTION_MAP(player_number, SKILL1)
	):
		skill1_pressed.emit()
		
	elif event.is_action_pressed(
		Strings.PLAYER_INPUT_ACTION_MAP(player_number, SKILL2)
	):
		skill2_pressed.emit()
