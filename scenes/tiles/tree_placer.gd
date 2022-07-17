extends Spatial

func _ready():
	randomize()
	var node1 = "tree_" + String(1 + randi() % 4)
	$tree_placer1.get_node(node1).visible = true
	$tree_placer1.rotation.y = randi() % 360
	
	var node2 = "tree_" + String(1 + randi() % 4)
	$tree_placer2.get_node(node2).visible = true
	$tree_placer2.rotation.y = randi() % 360
