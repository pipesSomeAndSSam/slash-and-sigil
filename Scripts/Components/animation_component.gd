# Component for managing player animations
extends Node2D
class_name AnimationComponent

#region Initialisations
# Variables
@export var sprite : AnimatedSprite2D

# Enum for which direction the player is facing
enum Direction {
	DOWN,
	UP,
	LEFT,
	RIGHT
}

# Variables for keeping track of the player facing mechanics
# Mechanics:
# 1. When a player is originally facing one direction only then
# adds another direction of the opposite axis (e.g., left
# then down), it should face the newly added direction.
# 2. In a circumstance where directions from both axes are 
# detected, the x-axis has higher precedence (e.g., if left
# and down, it becomes left then down)

# The direction the player is expected to face given the mechanics
var faced_direction : Direction  

# The original direction the player faced (e.g., if left then down,
# then left is the primary direction)
var _primary_direction : Direction = Direction.DOWN 
var _has_primary : bool = false 

# Signals
signal direction_faced_changed(direction: Direction)
signal animation_finished
#endregion

#region Signal Functions
# Signal that emits when an animation is finished
func _on_animated_sprite_animation_finished() -> void:
	animation_finished.emit()
#endregion

#region Action Animations
# Function for updating movement
# movement is a Vector2 that shows the direction of the player
func update_movement(movement: Vector2) -> void:
	# Checks if movement is a Zero Vector2
	# Plays Idle animations if so, or Walk animations otherwise
	if movement != Vector2.ZERO:
		if not _has_primary:
			# To obtain an x-axis precedence, the primary direction
			# will always be in the x-axis whenever there is a an
			# x-axis movement detected. Otherwise, the primary direction will be in the y-axis.
			if movement.x != 0:
				_primary_direction = _get_x_direction(movement.x)
			else:
				_primary_direction = _get_y_direction(movement.y)
			
			# If the player is moving, it automatically has a primary direction. 
			_has_primary = true
			
		else:
			# When the player is moving strictly in a direction of one axis, then the primary direction should be where the direction in which the player is going.
			if movement.x != 0 and movement.y == 0:
				_primary_direction = _get_x_direction(movement.x)
			elif movement.x == 0 and movement.y != 0:
				_primary_direction = _get_y_direction(movement.y)
		

		# If a primary direction exists and the movement vector
		# introduces movement in the axis opposite to the primary
		# direction, the player should be facing in the introduced
		# movement. 
		if _is_in_x_axis(_primary_direction) and movement.y != 0:
			faced_direction = _get_y_direction(movement.y)
		elif _is_in_y_axis(_primary_direction) and movement.x != 0:
			faced_direction = _get_x_direction(movement.x)
			
		# Otherwise, the faced direction is the primary direction.
		else:
			faced_direction = _primary_direction
	
		# Display the walking animation based on the faced direction
		_play_directional_anim(Strings.WALK, faced_direction)
		direction_faced_changed.emit(faced_direction)
		
	else:
		# When the player is idle, it does not have a primary direction and plays the idle animation of the direction it last faced.
		_has_primary = false
		_play_directional_anim(Strings.IDLE, faced_direction)
		direction_faced_changed.emit(faced_direction)

# Function for when the player attacks
func play_attack() -> void:
	_play_directional_anim(Strings.ATTACK, faced_direction)

# Function for when the player slashes with skill1
func play_skill1_slash() -> void:
	# TO DO: Change to slash anim
	_play_directional_anim(Strings.ATTACK, faced_direction)

# Function for when the player swings with skill1
func play_skill1_swing() -> void:
	# TO DO: Change to switch anim
	_play_directional_anim(Strings.ATTACK, faced_direction)

# Function that returns the direction where the player is facing
func get_facing_direction() -> Vector2:
	match faced_direction:
		Direction.LEFT:		return Vector2.LEFT
		Direction.RIGHT:	return Vector2.RIGHT
		Direction.UP:		return Vector2.UP
		Direction.DOWN:		return Vector2.DOWN
	
	# Default return is DOWN
	return Vector2.DOWN
#endregion

#region Helper Functions
# Function for changing the direction of the player and playing the right animations for idling and walking 
# prefix is a String that determines the action of the player
# direction is a Direction that shows where the player is facing
func _play_directional_anim(prefix: String, direction: Direction) -> void:
	sprite.play(Strings.default_anim_name(prefix, direction))
	
# Function that returns the corresponding direction based on the x movement
# x_magnitude is a float that determines where the player is heading with respect to the x-axis
func _get_x_direction(x_magnitude: float) -> Direction:
	return Direction.LEFT if x_magnitude < 0 else Direction.RIGHT

# Function that returns the corresponding direction based on the y movement
# y_magnitude is a float that determines where the player is heading with respect to the y-axis
func _get_y_direction(y_magnitude: float) -> Direction:
	return Direction.UP if y_magnitude < 0 else Direction.DOWN

# Function that checks if the direction is located within the x-axis
# direction is a Direction that shows where the player is facing
func _is_in_x_axis(direction: Direction) -> bool:
	return direction == Direction.LEFT or direction == Direction.RIGHT
	
# Function that checks if the direction is located within the y-axis
# direction is a Direction that shows where the player is facing
func _is_in_y_axis(direction: Direction) -> bool:
	return direction == Direction.UP or direction == Direction.DOWN
#endregion
