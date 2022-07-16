extends RigidBody

class_name Dice
func is_class(name): return name == "Dice" || .is_class(name)
func get_class(): return "Dice"

export (float) var toss_force = 1
export (float) var max_rot = 0.005

func toss(direction, force = toss_force):
	var rot = Vector3(
		rand_range(-max_rot, max_rot),
		rand_range(-max_rot, max_rot),
		rand_range(-max_rot, max_rot))
	
	var impulse = direction.normalized() * force
	apply_central_impulse(impulse)
	apply_torque_impulse(rot)

func _ready():
	yield(get_tree().create_timer(2), "timeout")
	toss(Vector3.UP)
