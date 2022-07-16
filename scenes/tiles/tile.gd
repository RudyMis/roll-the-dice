extends Spatial

export (float) var rotation_time = 0.4

onready var target_transform = transform
onready var start_transform = transform

var active = true

onready var tween = $Tween

func deactivate():
	active = false

func call_interpolation(weight):
	target_transform.origin = transform.origin
	transform = start_transform.interpolate_with(target_transform, weight)

func _input(event):
	if !active: return
	if Input.is_action_just_pressed("left"):
		start_transform = transform
		target_transform = target_transform.rotated(Vector3.UP, -PI / 2)
		tween.remove_all()
		tween.interpolate_method(self, "call_interpolation", 0, 1, rotation_time, Tween.TRANS_BACK, Tween.EASE_IN)
		tween.start()
	
	if Input.is_action_just_pressed("right"):
		start_transform = transform
		target_transform = target_transform.rotated(Vector3.UP, PI / 2)
		tween.remove_all()
		tween.interpolate_method(self, "call_interpolation", 0, 1, rotation_time, Tween.TRANS_BACK, Tween.EASE_IN)
		tween.start()

func _ready():
	pass # Replace with function body.
