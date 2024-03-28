extends Node2D

const BULLET_HITBOX = preload("res://examples/bullets/bullet_hitbox.tres")
const ICON = preload("res://icon.svg")

static var shared_area: RID

var bullets: Array[Bullet]

func _ready():
    var area2d = Area2D.new()
    add_child(area2d)
    shared_area = area2d.get_rid()
    PhysicsServer2D.area_set_monitorable(shared_area, false)
    PhysicsServer2D.area_set_space(shared_area, get_world_2d().space)
    PhysicsServer2D.area_set_collision_mask(shared_area, 1)
    PhysicsServer2D.area_set_collision_layer(shared_area, 1)
    PhysicsServer2D.area_set_area_monitor_callback(shared_area,
        func(_1, _2, _3, _4, idx):
            remove_bullet(idx))

func _process(delta: float) -> void:
    var used_transform = Transform2D()
    var bullets_queued_for_destruction = []
    
    for i in range(0, bullets.size()):
        
        # Calculate the new position
        var bullet = bullets[i] as Bullet   
        var offset : Vector2 = (
            bullet.movement_vector.normalized() * 
            bullet.speed * 
            delta
        )
        
        # Move the Bullet
        bullet.transform.origin += offset
        PhysicsServer2D.area_set_shape_transform(
            shared_area, i, bullet.transform)
        
        RenderingServer.canvas_item_set_transform(
            bullet.tex_id, bullet.transform)
        
        # Add the delta to the bullet's lifetime
        bullet.lifetime += delta

# Register a new bullet in the array
func spawn_bullet(origin: Vector2, i_movement: Vector2, speed: float) -> void:
    # Create the bullet instance
    var bullet : Bullet = Bullet.new()
    bullet.movement_vector = i_movement
    bullet.speed = speed
    bullet.transform = Transform2D(0, origin)

    # Configure its collision
    _configure_collision_for_bullet(bullet)

    bullet.tex_id = RenderingServer.canvas_item_create()
    RenderingServer.canvas_item_set_parent(bullet.tex_id, get_canvas_item())
    RenderingServer.canvas_item_add_texture_rect(
        bullet.tex_id, Rect2(-ICON.get_size() / 2, ICON.get_size()), ICON)

    # Register to the array
    bullets.append(bullet)
    call("tween_bullet", bullet)

func remove_bullet(idx: int):
    PhysicsServer2D.area_set_shape_disabled.bind(shared_area, idx, true).call_deferred()
    RenderingServer.canvas_item_clear(bullets[idx].tex_id)

func _configure_collision_for_bullet(bullet: Bullet) -> void:   
    var _circle_shape = PhysicsServer2D.circle_shape_create()
    PhysicsServer2D.shape_set_data(_circle_shape, 8)
    # Add the shape to the shared area
    PhysicsServer2D.area_add_shape(
        shared_area, _circle_shape, bullet.transform)

    bullet.shape_id = _circle_shape

func tween_bullet(b: Bullet):
    b.tween_instruction(create_tween())

class Bullet:
    var movement_vector: Vector2
    var speed: float
    var transform: Transform2D
    var lifetime: float

    var shape_id: RID
    var tex_id: RID
    
    func tween_instruction(t: Tween):
        t.set_parallel()
        t.tween_property(self, "speed", 500, 1)
        t.tween_property(self, "movement_vector", Vector2.DOWN, 1)
        t.chain()
        t.tween_property(self, "speed", 100, 1)
        return t
