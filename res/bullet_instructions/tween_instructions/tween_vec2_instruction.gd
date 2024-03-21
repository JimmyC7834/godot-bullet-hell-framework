## Tween a vector 2 property of the bullet
class_name TweenVec2Instruction
extends BulletTweenInstruction

## The property name to be tweened
@export var property_name: String

## The final value of the tween
@export var value: Vector2

## The duration of the tween
@export var duration: float = 1.0

## If set to [param true], the tween will be relative
@export var is_relative: bool = false
 
func _effect():
    var t = bullet.create_tween().parallel()
    if is_relative:
        value += bullet._get(property_name)
    t = interpolate_curve_property(t, curve, bullet, property_name, value, duration)
    
    if !parallel:
        return t.finished
