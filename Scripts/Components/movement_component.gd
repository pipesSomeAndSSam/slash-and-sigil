# Component for managing player movement
extends Node2D
class_name MovementComponent

# Variables
@export var speed : int

# Function for calculating the movement of the player
# movement is a Vector2 that shows the direction of the player
func calculate_movement(movement: Vector2) -> Vector2:
	return movement * speed 
