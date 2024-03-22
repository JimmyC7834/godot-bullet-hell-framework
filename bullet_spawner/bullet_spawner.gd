## Base class for bullet spawners
class_name BulletSpawner
extends Node2D

@export var spawn_pattern: BulletSpawnPattern

func trigger():
    pass

## Spawn bullets with pattern as defined [param spawn_pattern] at [param pos]
func spawn_sequence(pos: Vector2, rotation: float = 0):
    for i in spawn_pattern.get_bullet_sequence():
        if i is float:
            await get_tree().create_timer(i).timeout
        elif i is PackedScene:
            var inst = i.instantiate() as Node2D
            inst.global_position = pos
            inst.global_rotation = rotation
            get_parent().add_child(inst)
