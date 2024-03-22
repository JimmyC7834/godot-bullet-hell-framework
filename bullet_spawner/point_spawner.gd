## Spawn a inst squence at [param global_position], apply rotation
class_name PointSpawner
extends CustomSpawner

func trigger():
    spawn_sequence(global_position,
        func(b):
            b.global_rotation = global_rotation)
