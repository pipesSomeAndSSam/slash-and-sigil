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
# action is a String that details the current action of the player
# direction is an int, based on the Direction enum, that describes the current direction the player is facing
static func default_anim_name(action: String, direction: int) -> String:
	var dir_string = AnimationComponent.Direction.keys()[direction].to_lower()
	return "%s_%s" % [action, dir_string]

const WALK : String = "walk"
const IDLE : String = "idle"
const ATTACK : String = "attack"
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
