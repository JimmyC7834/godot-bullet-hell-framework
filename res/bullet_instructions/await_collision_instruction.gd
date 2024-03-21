class_name AwaitCollisionInstruction
extends BulletInstruction

@export var area: Area2D
@export_enum(&"AREA_ENTER", &"BODY_ENTER", &"AREA_SAHPE_ENTER", &"BODY_SAHPE_ENTER")
var type: String = &"AREA_ENTER"

func _effect():
    match type:
        &"AREA_ENTER":
            return area.area_entered
        &"BODY_ENTER":
            return area.body_entered
        &"AREA_SAHPE_ENTER":
            return area.area_shape_entered
        &"BODY_SAHPE_ENTER":
            return area.body_shape_entered
