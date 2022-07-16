extends Camera

export (float) var speed = -0.001
export (NodePath) var np_dice

onready var dice = get_node(np_dice)

func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.is_action_pressed("mouse_right"):
		transform = transform.translated(Vector3(event.relative.x, 0, event.relative.y) * speed)


func _on_roll_pressed():
	if dice and dice.is_class("Dice"):
		
		dice.roll(Vector3.UP, 2)
