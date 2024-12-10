extends Button


func _on_pressed() -> void:
	for i in get_tree().get_nodes_in_group("Characters"):
		i.queue_free()
