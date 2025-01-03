@tool
extends EditorScript


func _run():
	var image_path: String = "res://Misc resources/map images/trinidad.png"
	var tilemap: TileMapLayer = get_editor_interface().get_selection().get_selected_nodes()[0]
	var cell_size: int = 16 
	var white_tile_id: int = 2
	var black_tile_id: int = -1
	var atlas_coords = Vector2i(0,0)

	# Load the image
	var img = Image.new()
	var error = img.load(image_path)
	if error != OK:
		print("Failed to load image:", image_path)
		return
	
	# Get the TileMap
	if not tilemap:
		print("TileMap node not found")
		return
	
	# Clear existing tiles
	tilemap.clear()

	# Calculate the number of cells
	var cells_x = int(img.get_width() / cell_size)
	var cells_y = int(img.get_height() / cell_size)
	
	# Iterate through the cells
	for cell_y in range(cells_y):
		for cell_x in range(cells_x):
			# Calculate the region for the current cell
			var start_x = cell_x * cell_size
			var start_y = cell_y * cell_size
			var end_x = start_x + cell_size
			var end_y = start_y + cell_size
			
			# Analyze the cell region
			var is_white = false
			for y in range(start_y, min(end_y, img.get_height())):
				for x in range(start_x, min(end_x, img.get_width())):
					var color = img.get_pixel(x, y)
					if color.r > 0.5 and color.g > 0.5 and color.b > 0.5:  # Check for white
						is_white = true
						break
				if is_white:
					break
			
			# Set the appropriate tile
			var tile_id = white_tile_id if is_white else black_tile_id
			tilemap.set_cell(Vector2i(cell_x, cell_y), tile_id, atlas_coords, 0)
	
	print("TileMap generated from image!")
	
