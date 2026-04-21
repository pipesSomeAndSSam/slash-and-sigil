# Single Source of Truth for Debug Messages
extends Node2D
class_name Messages

#region Input Messages
static func player_movement_pressed(p_num: int, direction: Vector2):
	return "Player %d moved: (%.2f, %.2f)" % [p_num, direction.x, direction.y]
	
static func player_attack_pressed(p_num: int):
	return "Player %d attacked!" % p_num

static func player_skill1_pressed(p_num: int):
	return "Player %d Skill 1 pressed!" % p_num

static func player_skill2_pressed(p_num: int):
	return "Player %d Skill 2 pressed!" % p_num
#endregion

#region Health Messages
static func health_changed(name: String, damage: float, health: float) -> String:
	return "%s took %.2f damage. Current HP: %.2f" % [name, damage, health]
#endregion
