# Component for managing the melee player's attack
extends Area2D
class_name MeleeAttackComponent

#region Initializables
@export var damage : float
@export var attack_hitbox : CollisionShape2D

# Basis for hitbox changing
var hitbox_offset : Vector2
#endregion

# Initialize hitbox offset value
func _ready() -> void:
	hitbox_offset = attack_hitbox.position

# Function that returns all the damageable entities inside the attack hitbox
func get_targets() -> Array[Node2D]:
	# Get all possible targets
	var targets = get_overlapping_areas()
	
	# The array that returns all valid targets
	var valid_targets : Array[Node2D] = []
	
	# Valid targets are considered the following:
	# 1. The target has health 
	# 2. The target isn't in the valid target array
	# 3. The target is not targetting itself
	for target in targets:
		var player = target.get_parent()
		if not _has_health(target):
			continue
		if valid_targets.has(target):
			continue
		if _self_fire(player):
			continue
			
		valid_targets.append(player)
	
	return valid_targets

# Function that changes the hitbox every time the faced direction changes
func change_hitbox_direction(direction: AnimationComponent.Direction) -> void:
	match direction:
		AnimationComponent.Direction.LEFT:
			attack_hitbox.position = Vector2(-(hitbox_offset.x), hitbox_offset.y)
		AnimationComponent.Direction.RIGHT:
			attack_hitbox.position = Vector2(hitbox_offset)
		AnimationComponent.Direction.UP:
			attack_hitbox.position = Vector2(hitbox_offset.y, -(hitbox_offset.x))
		AnimationComponent.Direction.DOWN:
			attack_hitbox.position = Vector2(hitbox_offset.y, hitbox_offset.x)

#region Helper Functions
# Function that checks if the area has health
# area is an Area2D to be checked if it is damageable
func _has_health(area: Area2D) -> bool:
	return area is HealthComponent

# Function that checks if the player is hitting itself
# player is a Node2D that acts as the root node of the component
func _self_fire(player: Node2D) -> bool:
	return player == owner
#endregion
