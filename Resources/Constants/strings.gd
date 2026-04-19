# Single source of truth for script strings
extends Node
class_name Strings

#region General Component Names
const ANIMATION_COMPONENT_NAME : String = "AnimationComponent"
const HEALTH_COMPONENT_NAME : String = "HealthComponent"
const INPUT_COMPONENT_NAME : String = "InputComponent"
const MOVEMENT_COMPONENT_NAME : String = "MovementComponent"
#endregion

#region Melee Player Component Names
const MELEE_ATTACK_COMPONENT_NAME : String = "MeleeAttackComponent"
#endregion

#region Animation Names
# Default Animations
static func default_anim_name(type: String, direction: int) -> String:
	var dir_string = AnimationComponent.Direction.keys()[direction].to_lower()
	return "%s_%s" % [type, dir_string]
#endregion

#region Export Names
# Player Info
const STATS : String = "Stats"
const ANIMATION : String = "Animation"
#endregion

#region Input Names
static func player_input_movement_map(player_no: int, direction: String) -> String:
	return "player%d_%s" % [player_no, direction]

static func player_input_action_map(player_no: int, action: String) -> String:
	return "player%d_%s" % [player_no, action]
#endregion
