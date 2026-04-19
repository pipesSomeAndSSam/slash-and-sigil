# Resource for Player Information
extends Resource
class_name PlayerInfo

# Stats
@export_group(Strings.STATS)
@export var health: float
@export var speed: int
@export var attack: int

# Animation
@export_group(Strings.ANIMATION)
@export var sprite_frame: SpriteFrames
