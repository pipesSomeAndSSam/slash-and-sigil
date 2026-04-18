# Component for managing player animations
extends Node2D
class_name AnimationComponent

# Variables
@export var sprite : AnimatedSprite2D


enum Direction {
	DOWN,
	UP,
	LEFT,
	RIGHT
}
var faced_direction : Direction
var _primary_direction : Direction = Direction.DOWN
var _has_primary : bool = false

signal direction_faced_changed(direction: Direction)
signal animation_finished

func update_movement(movement: Vector2) -> void:
	if movement != Vector2.ZERO:
		if not _has_primary:
			# First frame: x wins if both active, otherwise whichever axis is moving
			if movement.x != 0:
				_primary_direction = Direction.LEFT if movement.x < 0 else Direction.RIGHT
			else:
				_primary_direction = Direction.UP if movement.y < 0 else Direction.DOWN
			_has_primary = true
		else:
			if movement.x != 0 and movement.y == 0:
				_primary_direction = Direction.LEFT if movement.x < 0 else Direction.RIGHT
			elif movement.x == 0 and movement.y != 0:
				_primary_direction = Direction.UP if movement.y < 0 else Direction.DOWN
		

		# Display: y overrides when primary is horizontal, but primary stays locked
		var display_direction : Direction
		if (_primary_direction == Direction.LEFT or _primary_direction == Direction.RIGHT) and movement.y != 0:
			display_direction = Direction.UP if movement.y < 0 else Direction.DOWN
		elif (_primary_direction == Direction.UP or _primary_direction == Direction.DOWN) and movement.x != 0:
			display_direction = Direction.LEFT if movement.x < 0 else Direction.RIGHT
		else:
			display_direction = _primary_direction
	
		faced_direction = display_direction
		_play_directional_anim("walk", display_direction)
	else:
		_has_primary = false
		_play_directional_anim("idle", faced_direction)

func _play_directional_anim(prefix: String, direction: Direction) -> void:
	match direction:
		Direction.LEFT:  sprite.play(prefix + "_left")
		Direction.RIGHT: sprite.play(prefix + "_right")
		Direction.UP:    sprite.play(prefix + "_up")
		Direction.DOWN:  sprite.play(prefix + "_down")
	
	direction_faced_changed.emit(direction)

func play_attack() -> void:
	print(Direction.find_key(faced_direction))
	match faced_direction:
		Direction.LEFT:		sprite.play("attack_left")
		Direction.RIGHT:	sprite.play("attack_right")
		Direction.UP:		sprite.play("attack_up")
		Direction.DOWN:		sprite.play("attack_down")


func _on_animated_sprite_animation_finished() -> void:
	animation_finished.emit()
