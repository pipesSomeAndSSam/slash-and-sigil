# Component for managing the melee player's attack
extends Area2D
class_name MeleeAttackComponent

@export var damage : float

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
		if _has_health(target) and (not valid_targets.has(target)) and (not _self_fire(player)):
			valid_targets.append(player)
	
	return valid_targets

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
