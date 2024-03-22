## Tween a vector 2 property of the bullet
class_name TweenFloatInstruction
extends PropertyTweenInstruction

## The property name to be tweened
@export var property_name: String

## The final value of the tween
@export var value: float

## The duration of the tween
@export var duration: float = 1.0

## If set to [param true], the tween will be relative
@export var is_relative: bool = false
 
func _effect():
    var t = node.create_tween().parallel()
    if is_relative:
        value += node.get(property_name)
    t = interpolate_curve_property(t, curve, node, property_name, value, duration)
    
    if !parallel:
        return t.finished
