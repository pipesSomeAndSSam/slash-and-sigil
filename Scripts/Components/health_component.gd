# Component for managing player health
extends Node2D
class_name HealthComponent

# Variables
@export var health : float

# Signals
signal player_damaged(damage: float)
signal player_died

# Function that calculates the damage taken by the player
# damage is an int that the player takes
func take_damage(damage: float) -> void:
	# Deduct player health with damage and emit signal that the player has damaged
	health = max(0, health - damage)
	player_damaged.emit(damage)
	
	# Emit signal that the player has died if health has reached 0 
	if not health:
		player_died.emit()
