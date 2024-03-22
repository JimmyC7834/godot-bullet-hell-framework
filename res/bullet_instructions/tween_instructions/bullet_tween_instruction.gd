class_name PropertyTweenInstruction
extends NodeInstruction

const DEFAULT_CURVE = preload("res://res/bullet_instructions/tween_instructions/default_curve.tres")

@export var curve: Curve
@export var parallel: bool

func register(b: Node2D):
    super.register(b)
    if curve == null:
        curve = DEFAULT_CURVE.duplicate()

# Tween a property using a custom interpolation method
func interpolate_property(tween : Tween, interpolator_method : Callable, object : Object, property : StringName, final_val : Variant, duration : float) -> MethodTweener:
    var inner_method := inner_interpolator.bind(interpolator_method, object, property, object.get(property), final_val)
    return tween.tween_method(inner_method, 0.0, 1.0, duration)

# Shortcut to directly use a curve instead of a method
func interpolate_curve_property(tween : Tween, interpolation_curve : Curve, object : Object, property : StringName, final_val : Variant, duration : float) -> MethodTweener:
    var interpolator_method := func(value, curve) -> float: return curve.sample_baked(value)
    interpolator_method = interpolator_method.bind(interpolation_curve)
    return interpolate_property(tween, interpolator_method, object, property, final_val, duration)

# Inner method, used by Tween.tween_method()
func inner_interpolator(tween_value : float, interpolator_method : Callable, object : Object, property: StringName, from : Variant, to : Variant):
    var interpolated_value = interpolator_method.call(tween_value)
    var interpolated_property
    
    if(interpolated_value is float):
        interpolated_property = (to - from) * interpolated_value + from
    else:
        interpolated_property = (to - from) * tween_value + from
        push_error(str(interpolator_method.get_object()) + "." + interpolator_method.get_method() + "() method does not return a float value")
    
    object.set(property, interpolated_property)
