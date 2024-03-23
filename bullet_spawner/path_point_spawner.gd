## Spawn insts sequence at each point on the [param path]
class_name PathPointSpawner
extends CustomSpawner

## Interval for spawning bullets on each points on the path
@export_range(0.0, 60.0) var interval: float

## The spawn path of bullets, the spawns occurs in order of the points
@export var path: Path2D

## If set to [param true], interval is added before the first shot
@export var wait_on_first: bool

func trigger():
    if wait_on_first:
        await get_tree().create_timer(interval).timeout

    for i in range(path.curve.point_count):
        spawn_sequence(path.curve.get_point_position(i))

        if interval > 0.0:
            await get_tree().create_timer(interval).timeout
