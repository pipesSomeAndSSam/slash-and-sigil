# Melee Player Implementation
extends BasePlayer
class_name MeleePlayer

# Components for Melee Player
@export_category("Melee Player Components")
@export var melee_attack_component : MeleeAttackComponent
@export var melee_skill1_component : MeleeSkill1Component

# State enum for state management
enum State {
	DEFAULT,
	ATTACK,
	SKILL1_SLASH,
	SKILL1_SWING,
	SKILL2
}

# Variable for state management
var player_state := State.DEFAULT

#region Signal Connections
# Function that connects to when player moves
# movement is a Vector2 that shows the direction of the player
func _on_input_component_player_moved(movement: Vector2) -> void:
	_move(movement)

# Function that connects to when player attacks
func _on_input_component_attack_pressed() -> void:
	_attack()

func _on_input_component_skill_1_pressed() -> void:
	_skill1()

func _on_melee_skill_1_component_slash_started(push_velocity: Vector2) -> void:
	player_state = State.SKILL1_SLASH
	velocity = push_velocity
	animation_component.play_skill1_slash()
	move_and_slide()

func _on_melee_skill_1_component_swing_started(lunge_velocity: Vector2) -> void:
	player_state = State.SKILL1_SWING
	velocity = lunge_velocity
	animation_component.play_skill1_swing()
	move_and_slide()

func _on_melee_skill_1_component_skill_1_finished() -> void:
	player_state = State.DEFAULT
	velocity = Vector2.ZERO
	
# Function that connects to when the player animation is finished
func _on_animation_component_animation_finished() -> void:
	match player_state:
		State.ATTACK:
			player_state = State.DEFAULT
		State.SKILL1_SWING:
			melee_skill1_component.finish_swing()
#endregion

#region Physics
# Function that decelerates while swinging
func _physics_process(delta: float) -> void:
	if player_state == State.SKILL1_SWING:
		velocity = velocity.move_toward(Vector2.ZERO, 10)
		move_and_slide()
#endregion

#region Player Actions
# Function that implements the movement logic given its components
# movement is a Vector2 that shows the direction of the player
func _move(movement: Vector2) -> void:
	# Can only move in DEFAULT state
	if player_state != State.DEFAULT:
		return
		
	# Calculate player movement
	var player_movement = movement_component.calculate_movement(movement)
	
	# Update movement and animation
	velocity = player_movement
	animation_component.update_movement(player_movement)
	move_and_slide()

# Function that implements the attack logic given its components
func _attack() -> void:
	# Can only attack in DEFAULT state
	if player_state != State.DEFAULT:
		return
	
	# Change state to ATTACK and play animation
	player_state = State.ATTACK 
	animation_component.play_attack()
	
	# Damage all damageable targets
	var targets = melee_attack_component.get_targets()
	for target in targets:
		var target_hp := target.get_node(Strings.HEALTH_COMPONENT_NAME) as HealthComponent
		target_hp.take_damage(melee_attack_component.damage)

# Function that executes the first skill of the player
# It should first slash in front, damaging all enemies, then swings, lunging forward and damaging all enemies hit.
func _skill1() -> void:
	# Can only use skill 1 in DEFAULT state
	if player_state != State.DEFAULT:
		return
		
	# Change state to SKILL1_SLASH and play animation
	player_state = State.SKILL1_SLASH
	var facing = animation_component.get_facing_direction()
	melee_skill1_component.execute(facing)
	animation_component.play_skill1_slash()
#endregion

func interrupt_skill1() -> void:
	melee_skill1_component.interrupt()
