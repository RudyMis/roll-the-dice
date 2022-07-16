extends Camera

export (float) var speed = -0.001

func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.is_action_pressed("mouse_right"):
		transform = transform.translated(Vector3(event.relative.x, 0, event.relative.y) * speed)
