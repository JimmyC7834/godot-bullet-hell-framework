class_name TweenVec2Instruction
extends BulletTweenInstruction

@export var property_name: String
@export var value: Vector2
@export var duration: float

func effect():
    var t = bullet.create_tween().parallel()
    t = interpolate_curve_property(t, curve, bullet, property_name, value, duration)
    
    if !parallel:
        return t.finished
