extends BasePlayer
class_name MeleePlayer
# TO DO: Assess whether some parts of this code can be transferred in 

# State enum for state management
enum State {
	DEFAULT,
	ATTACK,
	SKILL1,
	SKILL2
}


var player_state := State.DEFAULT

# Signal connections
# Function that connects to when player moved
# movement is a Vector2 that shows the direction of the player
#region Signal Connections
func _on_input_component_player_moved(movement: Vector2) -> void:
	_move(movement)

func _on_input_component_attack_pressed() -> void:
	_attack()

#endregion

# Player function implementations
func _move(movement: Vector2) -> void:
	if player_state == State.DEFAULT:
		# Calculate player movement
		var player_movement = movement_component.calculate_movement(movement)
		
		# Update movement and animation
		velocity = player_movement
		animation_component.update_movement(player_movement)
		move_and_slide()

func _attack() -> void:
	if player_state == State.DEFAULT:
		player_state = State.ATTACK
		animation_component.play_attack()


func _on_animation_component_animation_finished() -> void:
	if player_state == State.ATTACK:
		player_state = State.DEFAULT
