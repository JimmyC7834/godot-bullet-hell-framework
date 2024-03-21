class_name DelayInstruction
extends BulletInstruction

@export var time: float

func _effect():
    print("delaying: %d" % time)
    return bullet.get_tree().create_timer(time).timeout
