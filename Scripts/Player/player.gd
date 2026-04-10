extends CharacterBody2D

# Player Components
@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimationComponent

# TO DO: Make this function to cater to a particular player
# Function that connects to when player1 is moved
# movement is a Vector2 that shows the direction of the player
func _on_input_component_player_1_moved(movement: Vector2) -> void:
	var player_movement = movement_component.calculate_movement(movement)
	
	# Update movement and animation
	velocity = player_movement
	animation_component.update_animation(player_movement)
	move_and_slide()
