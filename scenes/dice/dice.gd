extends RigidBody

class_name Dice

func is_class(name): return name == "Dice" || .is_class(name)
func get_class(): return "Dice"

export (float) var toss_force = 1
export (float) var max_rot = 0.1

func roll(direction, force = toss_force):
	var rot = Vector3(
		rand_range(-max_rot, max_rot),
		rand_range(-max_rot, max_rot),
		rand_range(-max_rot, max_rot))
	
	var impulse = direction.normalized() * force
	apply_central_impulse(impulse)
	apply_torque_impulse(rot)

func get_side(nr: String):
	var side = $visual_sides.get_node(nr)
	if side.get_child_count() > 0:
		return side.get_children()[0]
	return null

func _ready():
	for side in $visual_sides.get_children():
		var new_side = SideGenerator.create_side()
		side.add_child(new_side)
