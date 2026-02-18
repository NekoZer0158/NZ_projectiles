@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Stop_moving.svg")
class_name RP_stop_moving
extends Remove_projectile

## Stops moving, instead of removing itself

func _remove_projectile_step_2(projectile:Node) -> void:
	check_particle_resource(projectile)
	projectile.can_move = false
