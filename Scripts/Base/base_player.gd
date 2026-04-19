# The base class that every player inherits
extends CharacterBody2D
class_name BasePlayer

# Player Components
@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var animation_component : AnimationComponent
@export var health_component : HealthComponent

# A player should be able to attack, use skills 1 and 2
func attack() -> void:
	pass

func skill_1() -> void:
	pass

func skill_2() -> void:
	pass
