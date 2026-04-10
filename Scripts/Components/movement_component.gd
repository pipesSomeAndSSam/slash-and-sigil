extends Node2D

@export var speed := 100

func _ready() -> void:
	# TO DO:
	# initialise speed based on the character
	pass

func calculate_movement(movement: Vector2) -> Vector2:
	return movement * speed
	
