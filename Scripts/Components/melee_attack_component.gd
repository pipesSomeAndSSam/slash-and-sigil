extends Area2D
class_name MeleeAttackComponent

@export var punch_hitbox : CollisionShape2D

func get_targets() -> Array[Node2D]:
	var targets = get_overlapping_bodies()
	
	var valid_targets : Array[Node2D] = []
	for target in targets:
		if target.has_node(Strings.HEALTH_COMPONENT_NAME) and not valid_targets.has(target):
			valid_targets.append(target)
	
	return valid_targets
