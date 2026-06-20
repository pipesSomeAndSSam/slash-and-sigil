extends Node2D

var temp_spawnpoints: Array[Vector2] = [Vector2(569.00, 327.00), Vector2(700, 327.00)]
var temp_players: Array[PlayerFactory.PlayerType] = [PlayerFactory.PlayerType.MELEE, PlayerFactory.PlayerType.MELEE]

@export var spawn_node : Node2D

func _ready() -> void:
	PlayerManager.spawn_players_in_map(temp_players, temp_spawnpoints, spawn_node)
