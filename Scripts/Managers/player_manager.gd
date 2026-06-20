# Script that manages player behaviours in scenes
extends Node

var current_players : Array[BasePlayer]

const PLAYER_SIZE : int = 2

func spawn_players_in_map(player_types: Array[PlayerFactory.PlayerType], spawnpoints: Array[Vector2], spawn_node: Node2D) -> void:
	current_players.clear()
	
	var number_of_players = player_types.size()
	var number_of_spawnpoints = spawnpoints.size()
	
	if number_of_players != PLAYER_SIZE:
		return
	
	if number_of_spawnpoints != PLAYER_SIZE:
		return 
	
	if not spawn_node:
		return
	
	for n in range(PLAYER_SIZE):
		var new_player := PlayerFactory.create_player(player_types[n], current_players.size())
		
		if not new_player:
			return
		
		current_players.append(new_player)
		new_player.global_position = spawnpoints[n]
		spawn_node.add_child(new_player)
	
