extends NavigationRegion2D

@export var tile_map : TileMapLayer  # Reference to your TileMap

func _ready() -> void:
	if tile_map:
	# Call the function to generate the Navigation Polygon from the TileMap
		update_navigation_polygon()
	else:
		push_error("tile_map is not assigned!")

func update_navigation_polygon() -> void:
	var nav_polygon = NavigationPolygon.new()
	var tileset = tile_map.tile_set
	var tilemap_size = tile_map.get_used_rect()
	
	# Loop through the TileMap and generate a polygon from walkable tiles
	for x in range(tilemap_size.position.x, tilemap_size.position.x + tilemap_size.size.x):
		for y in range(tilemap_size.position.y, tilemap_size.position.y + tilemap_size.size.y):
			var cell = tile_map.get_cell(x, y)
			if cell != -1:
				var tile = tileset.get_tile(cell)
				
				# If the tile is walkable, create a polygon for that tile
				if tile.has_collision():
					# You can customize this depending on your tile's collision shape
					var shape = tile.collision_shape
					if shape:
						nav_polygon.add_polygon(shape.get_points())
	
	# Set the generated polygon to the NavigationRegion2D
	self.navigation_polygon = nav_polygon
