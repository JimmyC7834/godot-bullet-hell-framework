@tool
## Spawn a bullet squence at [param global_position] 
class_name CircularSpawner
extends BulletSpawner

@export_range(0, 90) var point_count: int
@export_range(0, 360) var degree: int
@export var radius: int
@export var apply_rotation: bool

var spawn_points: Array[Vector2] = []

func _ready():
    calculate_spawn_points()

func trigger():
    for p in spawn_points:
        spawn_sequence(global_position + p.rotated(global_rotation), p.angle() + rotation)
        #print(rad_to_deg(p.angle() + rotation))
    
func calculate_spawn_points():
    spawn_points.clear()
    var d_angle = float(degree) / point_count
    for i in range(point_count):
        var p = Vector2.from_angle(deg_to_rad(i * d_angle)) * radius
        spawn_points.append(p)

func _process(delta):
    calculate_spawn_points()
    queue_redraw()
    
func _draw():
    for p in spawn_points:
        draw_line(Vector2.ZERO, p, Color.AQUA, 3)
