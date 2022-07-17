extends Camera

signal tile_chosen

export (float) var speed = -0.025
export (NodePath) var np_dice_controller

var count = 0

onready var button = $CanvasLayer/MarginContainer/Button
onready var dice_controller = get_node(np_dice_controller)

func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.is_action_pressed("mouse_right"):
		var transformed = transform.basis.xform(Vector3(event.relative.x, 0, event.relative.y)) * speed
		transformed.y = 0
		transform.origin += transformed

func _on_roll_pressed():
	button.disabled = true
	var dice = dice_controller.get_node("Dice")
	if dice and dice.is_class("Dice"):
		var dice_target_position = viewport_to_map(get_viewport().size * Vector2(0.5, 0.75))
		if dice_target_position:
			dice_controller.roll(Vector3.UP + (dice_target_position - dice.transform.origin) / 10)

func viewport_to_map(pos: Vector2):
	var dropPlane  = Plane(Vector3(0, 1, 0), 0)
	return dropPlane.intersects_ray(project_ray_origin(pos), project_ray_normal(pos))

func add_new_tile():
	$CanvasLayer/MarginContainer/new_tile_gui.visible = true
	for child in get_children():
		if child is Spatial:
			var side = SideGenerator.create_side()
			child.add_child(side)

func _on_tile_placed():
	count += 1
	if count >= 3:
		count = 0
		add_new_tile()
	else:
		button.disabled = false

func _on_new_tile_chosen(tile_idx):
	$CanvasLayer/MarginContainer/new_tile_gui.visible = false
	for handler in get_children():
		if handler is Spatial:
			for child in handler.get_children():
				child.call_deferred("queue_free")
	button.disabled = false
	var tile = get_node(str(tile_idx)).get_children()[0]
	emit_signal("tile_chosen", tile.duplicate())
