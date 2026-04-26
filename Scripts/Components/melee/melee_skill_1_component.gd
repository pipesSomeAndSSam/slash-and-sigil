# Component for Managing the Melee Player's Skill 1
extends Node2D
class_name MeleeSkill1Component

#region Initialisations
# Variables
@export_category("Melee Skill Variables")
@export var slash_push : float = 120.0
@export var swing_lunge : float = 300.0
@export var cooldown_duration : float = 4.0
@export var slash_damage : float = 8.0
@export var swing_damage : float = 15.0

# Components
@export_category("Melee Skill Components")
@export var slash_hitbox : Area2D
@export var swing_hitbox : Area2D
@export var cooldown_timer : Timer

# Direction for applying the skill
var _facing : Vector2 = Vector2.ZERO
var can_execute : bool = true

# Constants
const SHAPE_NAME : String = "Shape"

# Signals
signal slash_started(push_velocity: Vector2)
signal swing_started(lunge_velocity: Vector2)
signal skill1_finished
#endregion

#region Signal connections
func _on_cooldown_timer_timeout() -> void:
	can_execute = true
	
func _on_slash_area_area_entered(area: Area2D) -> void:
	_apply_damage(area, slash_damage)

func _on_swing_area_area_entered(area: Area2D) -> void:
	_apply_damage(area, swing_damage)
#endregion

#region Action Functions
# Function that executes the skill
func execute(facing: Vector2) -> void:
	# Initialise defaults
	can_execute = false
	_facing = facing
	
	# Toggle hitboxes to avoid overlapping
	_toggle_hitbox(slash_hitbox, true)
	_toggle_hitbox(swing_hitbox, false)
	
	# Emit signal that slash has started
	slash_started.emit(_facing * slash_push)
	
	# Activate timer
	cooldown_timer.one_shot = true
	cooldown_timer.wait_time = cooldown_duration
	cooldown_timer.start()

# Function that starts the swing, called after the slash animation finishes
func start_swing() -> void:
	_toggle_hitbox(swing_hitbox, true)
	_toggle_hitbox(slash_hitbox, false)
	swing_started.emit(_facing * swing_lunge)

# Function that finished the swing, called when the swing animation finishes
func finish_swing() -> void:
	_toggle_hitbox(swing_hitbox, false)
	skill1_finished.emit()

# Function that interrupts the skill mid-execution
func interrupt() -> void:
	# Disable all hitboxes
	_toggle_hitbox(slash_hitbox, false)
	_toggle_hitbox(swing_hitbox, false)
	
	skill1_finished.emit()
#endregion

#region Helper functions
# Function that applies damage to damageable entities
# area is an Area2D that is subject to damage
func _apply_damage(area: Area2D, damage: float) -> void:
	# The area should have a health component
	if not _has_health(area):
		return
	
	# The area should not belong to the same owner as the owner of this component
	var parent = area.owner
	if _self_fire(parent):
		return
	
	var damageable : HealthComponent = area as HealthComponent
	damageable.take_damage(damage)
	
# Function that toggles a particular hitbox
# area is an Area2D that holds the shape of the hitbox
# enabled is a bool that sets whether the hitbox is enabled or disabled
func _toggle_hitbox(hitbox: Area2D, enabled: bool) -> void:
	var shape := hitbox.get_node(SHAPE_NAME) as CollisionShape2D
	if shape:
		shape.disabled = not enabled

# Function that checks if the area has a health component
# area is an Area2D to be checked if it is damageable
func _has_health(area: Area2D) -> bool:
	return area is HealthComponent

# Function that checks if the player is hitting itself
# player is a Node2D that acts as the root node of the component
func _self_fire(player: Node2D) -> bool:
	return player == owner
#endregion
