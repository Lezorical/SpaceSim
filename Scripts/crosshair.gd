extends CenterContainer

var dot_radius : float = 2
var dot_color : Color = Color.WHITE

func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	draw_circle(Vector2(0,0), dot_radius, dot_color)
