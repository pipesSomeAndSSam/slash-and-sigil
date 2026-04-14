extends BasePlayer
class_name MeleePlayer

# Signal connections
# Function that connects to when player moved
# movement is a Vector2 that shows the direction of the player
#region Signal Connections
func _on_input_component_player_moved(movement: Vector2) -> void:
	_move(movement)

func _on_input_component_attack_pressed() -> void:
	pass # Replace with function body.

#endregion

# Player function implementations
func _move(movement: Vector2) -> void:
	# Calculate player movement
	var player_movement = movement_component.calculate_movement(movement)
	
	# Update movement and animation
	velocity = player_movement
	animation_component.update_movement(player_movement)
	move_and_slide()

func _attack() -> void:
	# Play attack functions
	animation_component.play_attack()
	pass
	
