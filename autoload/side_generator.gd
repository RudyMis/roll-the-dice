extends Node

var ps_side = preload("res://scenes/dice/side.tscn")
var all_types = ["factory", "house", "tree", "water"]
var all_dividers = ["road"]
var divider_chance = 0.5
var sprites_directory = "res://assets/sprites/"
var mesh_directory = "res://scenes/dividers/"

func get_files(directory: String, prefix: String, sufix: String):
	var files = []
	var dir = Directory.new()
	dir.open(directory)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.begins_with(prefix) and file.ends_with(sufix):
			files.append(file)

	dir.list_dir_end()
	return files

func create_divider(types = all_dividers):
	if randf() > divider_chance:
		return null
	
	var type = randi() % len(types)
	# FIXME: Give correct path to mesh files
	var mesh_files = get_files(mesh_directory, types[type], ".tscn")
	if len(mesh_files) == 0:
		print("No meshes for type: ", types[type])
		return null
	var mesh_idx = randi() % len(mesh_files)
	var ps_mesh = load(mesh_directory + mesh_files[mesh_idx])
	if ps_mesh and ps_mesh.has_method("instance"):
		var mesh = ps_mesh.instance()
		var direction = randi() % 4
		mesh.rotate_x(-PI / 2)
		mesh.rotate_z(direction * PI / 2)
		return mesh
	return null

func create_side(types = all_types):
	randomize()
	var side = ps_side.instance()
	
	# Fields
	for i in range(4):
		var type = randi() % len(types)
		var texture_files = get_files(sprites_directory, types[type], ".png")
		if len(texture_files) == 0:
			print("No textures for type: ", types[type])
			continue
		var texture_idx = randi() % len(texture_files)
		side.set_field(str(i), load(sprites_directory + texture_files[texture_idx]))
	
	var divider = create_divider()
	if divider:
		divider.scale *= Vector3.ONE / side.scale
		side.add_child(divider)
	
	return side

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
