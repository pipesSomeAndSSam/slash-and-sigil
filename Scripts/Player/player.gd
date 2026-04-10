extends CharacterBody2D

# Player Components
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent

# Function that connects to when player moved
# movement is a Vector2 that shows the direction of the player
func _on_input_component_player_moved(movement: Vector2) -> void:
	# Calculate player movement
	var player_movement = movement_component.calculate_movement(movement)
	
	# Update movement and animation
	velocity = player_movement
	animation_component.update_animation(player_movement)
	move_and_slide()
