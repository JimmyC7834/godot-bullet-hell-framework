## Spawn pattern that spawns insts on a constant interval
class_name ConstantIntervalPattern
extends InstSpawnPattern

## Interval for spawning insts
@export_range(0.0, 60.0) var interval: float

## If set to [param true], interval is added before the first shot
@export var wait_on_first: bool

func get_bullet_sequence() -> Array:
    var arr = []
    if wait_on_first:
        arr.append(interval)
    
    for s in scenes:
        arr.append(s)
        arr.append(interval)

    return arr
