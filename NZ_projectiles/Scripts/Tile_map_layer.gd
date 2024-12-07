extends TileMapLayer


func _remove_tile_map_layer() -> void:
	queue_free()
