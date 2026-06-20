# Factory for creating players
extends Node
class_name PlayerFactory

# Types of Players
enum PlayerType { MELEE, NINJA, MAGE }

# Paths of the scenes of the player types
const _PATHS = {
	PlayerType.MELEE: "res://Scenes/PlayerAnimation/MeleePlayer.tscn",
	PlayerType.NINJA: "res://Scenes/PlayerAnimation/NinjaPlayer.tscn",
	PlayerType.MAGE: "res://Scenes/PlayerAnimation/MagePlayer.tscn"
}

# Lazy Loading Cache
static var _cache: Dictionary = {}


static func create_player(player_type: PlayerType, player_id: int) -> BasePlayer:
	if not _PATHS.has(player_type):
		return null
		
	if not _cache.has(player_type):
		_cache[player_type] = load(_PATHS[player_type]) as PackedScene
		
	var player = _cache[player_type].instantiate() as BasePlayer
	if player:
		player.player_id = player_id 
		
	return player
