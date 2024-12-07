@icon("res://addons/NZ_projectiles/Icons/Projectile.svg")
class_name RP_dont
extends Remove_projectile

func remove_projectile(projectile:Projectile) -> void:
	check_particle_resource(projectile)
