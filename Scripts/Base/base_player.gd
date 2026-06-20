# base_player.gd
extends CharacterBody2D
class_name BasePlayer

@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var animation_component : AnimationComponent
@export var health_component : HealthComponent

# Keeps track of the ID until ready
var player_id: int = 1 

func _ready() -> void:
	# At this point, add_child() was called, so input_component is guaranteed to exist
	if not input_component:
		return
	
	input_component.player_number = player_id

# Standardized naming conventions across all players
func _attack() -> void:
	pass

func _skill_1() -> void:
	pass

func _skill_2() -> void:
	pass
