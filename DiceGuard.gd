extends RayCast

export (NodePath) var np_dice
onready var dice = get_node(np_dice)

var last_pos = translation
var stop = true

func _process(delta):
	translation = dice.translation
	var collider = get_collider()
	var pos = translation
	if (collider != null):
		if (pos.distance_squared_to(last_pos) < 1e-8):
			if stop == false:
				var colliding = 7 - int(collider.get_name()[5])
				print("Wyrzucono: " + String(colliding))
				stop = true
		else:
			stop = false
	last_pos = pos