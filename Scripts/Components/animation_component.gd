extends Node2D
class_name AnimationComponent

@export var sprite : AnimatedSprite2D
var last_faced_direction := Vector2.ZERO

func update_animation(movement: Vector2) -> void:
	if movement != Vector2.ZERO:
		last_faced_direction = movement
		
		if movement.x < 0:
			sprite.play("walk_left")
		elif movement.x > 0:
			sprite.play("walk_right")
		elif movement.y > 0:
			sprite.play("walk_down")
		elif movement.y < 0:
			sprite.play("walk_up")
	
	else:
		if last_faced_direction.x < 0:
			sprite.play("idle_left")
		elif last_faced_direction.x > 0:
			sprite.play("idle_right")
		elif last_faced_direction.y > 0:
			sprite.play("idle_down")
		elif last_faced_direction.y < 0:
			sprite.play("idle_up")
