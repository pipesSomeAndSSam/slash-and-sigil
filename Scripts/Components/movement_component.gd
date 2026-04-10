extends Node2D
class_name MovementComponent

@export var speed : int

func calculate_movement(movement: Vector2) -> Vector2:
	return movement * speed 
