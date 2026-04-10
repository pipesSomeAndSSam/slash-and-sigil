# Component for managing player animations
extends Node2D
class_name AnimationComponent

# Variables
@export var sprite : AnimatedSprite2D
var last_faced_direction := Vector2.ZERO

# Function that updates the sprite based on player movement
# movement is a Vector2D that shows the direction of the player
func update_animation(movement: Vector2) -> void:
	# If the player is moving, update the last faced direction and play appropriate walking animation
	if movement != Vector2.ZERO:
		last_faced_direction = movement
		
		if movement.x < 0:
			sprite.play("walk_left")
		elif movement.x > 0:
			sprite.play("walk_right")
		elif movement.y > 0:
			sprite.play("walk_down")
		elif movement.y < 0:
			sprite.play("walk_up")
	
	# Otherwise, play the appropriate idle animation
	else:
		if last_faced_direction.x < 0:
			sprite.play("idle_left")
		elif last_faced_direction.x > 0:
			sprite.play("idle_right")
		elif last_faced_direction.y > 0:
			sprite.play("idle_down")
		elif last_faced_direction.y < 0:
			sprite.play("idle_up")
