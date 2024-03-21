@tool
extends Path2D

@export var preview_resolution: int
@export var preview: bool:
    set(x):
        generate_path_pts()
        update_preview()
        on_preview.emit()

@export var x: Curve:
    set(value):
        x = value
        on_preview.emit()

@export var y: Curve:
    set(value):
        y = value        
        on_preview.emit()

@export var is_velocity: bool

var preview_pts = []

signal on_preview

func _ready():
    curve = Curve2D.new()
    on_preview.connect(func():
        generate_path_pts()
        update_preview())

func generate_path_pts():
    var pts = []
    var step: float = 1.0 / preview_resolution
    for i in range(preview_resolution):
        var value = step * i
        pts.append(Vector2(x.sample(value), y.sample(value)))

    preview_pts = pts

func update_preview():
    curve.clear_points()
    for p in preview_pts:
        curve.add_point(p)
