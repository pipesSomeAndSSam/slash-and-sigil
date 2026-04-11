extends CharacterBody2D

@export var input_component: InputComponent
@export var movement_component: MovementComponent
@export var animation_component: AnimatedSprite2D

var last_faced_direction := Vector2.ZERO

func update_animation(movement: Vector2) -> void:
	if movement != Vector2.ZERO:
		last_faced_direction = movement
		
		if movement.x < 0:
			animation_component.play("walk_left")
		elif movement.x > 0:
			animation_component.play("walk_right")
		elif movement.y > 0:
			animation_component.play("walk_down")
		elif movement.y < 0:
			animation_component.play("walk_up")
	
	else:
		if last_faced_direction.x < 0:
			animation_component.play("idle_left")
		elif last_faced_direction.x > 0:
			animation_component.play("idle_right")
		elif last_faced_direction.y > 0:
			animation_component.play("idle_down")
		elif last_faced_direction.y < 0:
			animation_component.play("idle_up")

func _on_input_component_player_1_moved(movement: Vector2) -> void:
	var player_movement = movement_component.calculate_movement(movement)
	
	velocity = player_movement
	update_animation(player_movement)
	
	move_and_slide()
