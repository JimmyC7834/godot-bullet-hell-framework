## Base class for spawners
## Spawners are responsible for spawning insts in defined
## positions and rotations, etc
class_name CustomSpawner
extends Node2D

@export var spawn_pattern: InstSpawnPattern

signal on_inst_spawned(inst: Node2D)

func trigger():
    pass

## Spawn bullets with pattern as defined [param spawn_pattern] at [param pos]
## call [param spawn_func] on every spawned inst after adding to the tree
func spawn_sequence(pos: Vector2, spawn_func: Callable = func(_inst):):
    for i in spawn_pattern.get_bullet_sequence():
        if i is float:
            await get_tree().create_timer(i).timeout
        elif i is PackedScene:
            var inst = i.instantiate() as Node2D
            inst.global_position = pos
            spawn_func.call(inst)
            get_parent().add_child(inst)
            on_inst_spawned.emit(inst)
