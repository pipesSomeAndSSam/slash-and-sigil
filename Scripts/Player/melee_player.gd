# Melee Player Implementation
extends BasePlayer
class_name MeleePlayer

# TO DO: Assess whether some parts of this code can be transferred to Base Player

# State enum for state management
enum State {
	DEFAULT,
	ATTACK,
	SKILL1,
	SKILL2
}

# Variable for state management
var player_state := State.DEFAULT

#region Signal Connections
# Function that connects to when player moves
# movement is a Vector2 that shows the direction of the player
func _on_input_component_player_moved(movement: Vector2) -> void:
	_move(movement)

# Function that connects to when player attacks
func _on_input_component_attack_pressed() -> void:
	_attack()

# Function that connects to when the player animation is finished
func _on_animation_component_animation_finished() -> void:
	if player_state == State.ATTACK:
		player_state = State.DEFAULT
#endregion


# Function that implements the movement logic given its components
# movement is a Vector2 that shows the direction of the player
func _move(movement: Vector2) -> void:
	if player_state == State.DEFAULT:
		# Calculate player movement
		var player_movement = movement_component.calculate_movement(movement)
		
		# Update movement and animation
		velocity = player_movement
		animation_component.update_movement(player_movement)
		move_and_slide()

# Function that implements the attack logic given its components
func _attack() -> void:
	if player_state == State.DEFAULT:
		player_state = State.ATTACK
		animation_component.play_attack()
