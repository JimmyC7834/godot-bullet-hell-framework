## Spawn pattern that spawns bullets on a constant interval
class_name ConstantIntervalPattern
extends BulletSpawnPattern

## Interval for spawning bullets
@export_range(0.0, 60.0) var interval: float

## If set to [param true], interval is added before the first shot
@export var wait_on_first: bool

func get_bullet_squence() -> Array:
    var arr = []
    if wait_on_first:
        arr.append(interval)        
    
    for b in bullets:
        arr.append(b)
        arr.append(interval)

    return arr
