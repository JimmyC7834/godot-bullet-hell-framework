extends Area2D

func _ready():
    area_shape_entered.connect(
        func(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int):
            #Bullets.remove_bullet(area_shape_index)
            area.get_parent().hide()
            area.get_parent().set_process(false)            
    )
