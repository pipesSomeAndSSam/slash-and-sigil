# player_manager.gd
extends Node

var current_players : Array[BasePlayer] = []
const MAX_PLAYERS : int = 2

func spawn_players_in_map(player_types: Array[PlayerFactory.PlayerType], spawnpoints: Array[Vector2], spawn_node: Node2D) -> void:
	current_players.clear()
	
	# Clean guard clause verification
	if player_types.size() != MAX_PLAYERS or spawnpoints.size() != MAX_PLAYERS or not spawn_node:
		push_error("Invalid setup for player spawning.")
		return
	
	for n in range(MAX_PLAYERS):
		# Pass n + 1 straight here as the ID
		var new_player := PlayerFactory.create_player(player_types[n], n + 1)
		if not new_player: 
			continue
			
		current_players.append(new_player)
		new_player.global_position = spawnpoints[n]
		spawn_node.add_child(new_player) # This triggers _ready() inside the player
