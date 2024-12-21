@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Stop_moving.svg")
class_name RP_stop_moving
extends Remove_projectile

func remove_projectile(projectile:Projectile) -> void:
	check_particle_resource(projectile)
	projectile.can_move = false
