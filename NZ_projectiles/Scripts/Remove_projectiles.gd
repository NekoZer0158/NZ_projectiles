extends Button

@export var dont_remove_this : Projectile_extended

func _on_pressed() -> void:
	for i in get_tree().get_nodes_in_group("Projectiles_extended"):
		if i != dont_remove_this:
			i.queue_free()
