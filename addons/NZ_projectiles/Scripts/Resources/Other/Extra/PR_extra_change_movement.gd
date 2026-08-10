class_name PR_extra_change_movement
extends Projectile_resource_extra

@export_node_path("Move_extended_projectile_node") var movement_node_path : NodePath

func use_extra(cur_projectile:Node) -> void:
	if cur_projectile.has_node(movement_node_path):
		cur_projectile.n_move_extended = cur_projectile.get_node(movement_node_path)
	else:
		push_error("Node2D with path ",movement_node_path," wasn't found")
