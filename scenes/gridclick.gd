extends GridMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var position2D = get_viewport().get_mouse_position()
	var dropPlane  = Plane(Vector3(0, 1, 0), 0)
	var position3D = dropPlane.intersects_ray($"../Camera".project_ray_origin(position2D),$"../Camera".project_ray_normal(position2D))
	if (position3D != null):
		position3D.x = round(position3D.x)
		position3D.z = round(position3D.z)
		$"../MeshInstance".translation = position3D
