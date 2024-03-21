## Base class for bullet spawners
class_name BulletSpawner
extends Node2D

@export var spawn_pattern: BulletSpawnPattern

func trigger():
    pass

## Spawn bullets with pattern as defined [param spawn_pattern] at [param pos]
func spawn_sequence_at(pos: Vector2):
    for i in spawn_pattern.get_bullet_sequence():
        if i is float:
            await get_tree().create_timer(i).timeout
        elif i is PackedScene:
            var inst = i.instantiate()
            inst.global_position = pos
            add_child(inst)
