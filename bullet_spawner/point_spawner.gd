## Spawn a bullet squence at [param global_position] 
class_name PointSpawner
extends BulletSpawner

func trigger():
    spawn_sequence(global_position, global_rotation)
