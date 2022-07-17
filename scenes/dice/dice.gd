extends RigidBody

class_name Dice

func is_class(name): return name == "Dice" || .is_class(name)
func get_class(): return "Dice"

export (float) var toss_force = 1
export (float) var max_rot = 0.1

onready var hit1 = load("res://assets/sounds/impact1.wav")
onready var hit2 = load("res://assets/sounds/impact2.wav")

func roll(direction, force = toss_force):
	var rot = Vector3(
		rand_range(-max_rot, max_rot),
		rand_range(-max_rot, max_rot),
		rand_range(-max_rot, max_rot))
	
	var impulse = direction.normalized() * force
	apply_central_impulse(impulse)
	apply_torque_impulse(rot)

func _ready():
	for side in $visual_sides.get_children():
		var new_side = SideGenerator.create_side()
		side.add_child(new_side)

func _on_Dice_collision(body):
	print("puk")
	if randi() % 2 == 1:
		$CollisionSound.stream = hit1
	else:
		$CollisionSound.stream = hit2
	$CollisionSound.play()
	pass # Replace with function body.
