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
# Attack Animation
const ATTACK_LEFT_MAP : String = "attack_left"
const ATTACK_RIGHT_MAP : String = "attack_right"
const ATTACK_UP_MAP : String = "attack_up"
const ATTACK_DOWN_MAP : String = "attack_down"

# Default Animations
static func DEFAULT_ANIM_NAME(type: String, direction: int) -> String:
	var dir_string = AnimationComponent.Direction.keys()[direction].to_lower()
	return "%s_%s" % [type, dir_string]
#endregion

#region Export Names
# Player Info
const STATS : String = "Stats"
const ANIMATION : String = "Animation"
#endregion

#region Input Names
static func PLAYER_INPUT_MOVEMENT_MAP(player_no: int, direction: String) -> String:
	return "player%_%" % [player_no, direction]

static func PLAYER_INPUT_ACTION_MAP(player_no: int, action: String) -> String:
	return "player%_%" % [player_no, action]
#endregion
