## Spawn a bullet squence at [param global_position] 
class_name PointBulletSpawner
extends BulletSpawner

func trigger():
    spawn_sequence_at(global_position)
