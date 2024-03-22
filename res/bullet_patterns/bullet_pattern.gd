## Base class for bullet spawning patterns
class_name InstSpawnPattern
extends Resource

## The list of bullets in the pattern
@export var scenes: Array[PackedScene]

## Returns an [Array] of [float] and [PackedScene],
## each [PackedScene] is the bullet to be spawned, while each [float] is the interval
## Should be overrided to define the behaviour of this pattern
func get_scenes_sequence() -> Array:
    return scenes
