extends Spatial

var last_pos = Vector3(0, 0, 0)
const plane  = Plane(Vector3(0, 1, 0), 0)

export var transition_speed = 0.1

func _process(delta):
	var pos2d = get_viewport().get_mouse_position()
	var pos3d = plane.intersects_ray($"../Camera".project_ray_origin(pos2d),$"../Camera".project_ray_normal(pos2d))
	if (pos3d != null):
		var r_pos3d = pos3d
		r_pos3d.x = round(r_pos3d.x) * 2
		r_pos3d.z = round(r_pos3d.z) * 2
		if last_pos != r_pos3d:
			# animate movement
			if $Tween.is_active():
				$Tween.stop_all()
				$Tween.remove_all()
				last_pos = $light.translation
			$Tween.interpolate_property($light, "translation",
				last_pos, r_pos3d, transition_speed,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#			$Tween.interpolate_property($movable_segment, "translation",
#				last_pos, r_pos3d, transition_speed,
#				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()
			$movable_segment.translation = r_pos3d
			last_pos = r_pos3d
		for child in $movable_segment.get_children():
			var cpos = child.translation + $movable_segment.translation
			cpos.y = 0
			child.scale = Vector3.ONE * (1 - cpos.distance_squared_to(pos3d*2) / 10)
