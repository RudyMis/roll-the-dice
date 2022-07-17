extends Camera

export (float) var speed = -0.025
export (NodePath) var np_dice_controller

onready var dice_controller = get_node(np_dice_controller)

func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.is_action_pressed("mouse_right"):
		var transformed = transform.basis.xform(Vector3(event.relative.x, 0, event.relative.y)) * speed
		transformed.y = 0
		transform.origin += transformed

func _on_roll_pressed():
	var dice = dice_controller.get_node("Dice")
	if dice and dice.is_class("Dice"):
		var dice_target_position = viewport_to_map(get_viewport().size * Vector2(0.5, 0.5))
		
		if dice_target_position:
			dice_controller.roll(Vector3.UP + (dice_target_position - dice.transform.origin) / 10)

func viewport_to_map(pos: Vector2):
	var dropPlane  = Plane(Vector3(0, 1, 0), 0)
	return dropPlane.intersects_ray($"../Camera".project_ray_origin(pos), $"../Camera".project_ray_normal(pos))
