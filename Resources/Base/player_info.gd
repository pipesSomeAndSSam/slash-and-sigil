extends Resource
class_name PlayerInfo

# Stats
@export_group("Stats")
@export var health: int
@export var speed: int
@export var attack: int

# Animation
@export_group("Animation")
@export var sprite_frame: SpriteFrames
