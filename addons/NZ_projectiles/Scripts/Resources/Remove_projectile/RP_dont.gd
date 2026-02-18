@icon("res://addons/NZ_projectiles/Icons/Projectile.svg")
class_name RP_dont
extends Remove_projectile

## Doesn't remove projectile

## Makes projectile invinsible
func _remove_projectile_step_2(projectile:Node) -> void:
	check_particle_resource(projectile)
