extends Node

enum PlayerType {
	MELEE,
	NINJA,
	MAGE
}

const MELEE_PLAYER_SCENE: PackedScene = preload("res://Scenes/PlayerAnimation/MeleePlayer.tscn")
const NINJA_PLAYER_SCENE: PackedScene = preload("res://Scenes/PlayerAnimation/NinjaPlayer.tscn")
const MAGE_PLAYER_SCENE: PackedScene = preload("res://Scenes/PlayerAnimation/MagePlayer.tscn")

static func create_player(player_type: PlayerType, player_count: int) -> BasePlayer:
	match player_type:
		PlayerType.MELEE:
			var player = MELEE_PLAYER_SCENE.instantiate() as MeleePlayer
			
			player.set_player_number(player_count + 1)
			return player
		PlayerType.NINJA:
			return null
		PlayerType.MAGE:
			return null
	return null
