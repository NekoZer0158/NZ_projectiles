@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Default.svg")
class_name Remove_projectile
extends Projectile_resource

@export var particle_resource : Particle_projectile

## DON'T EDIT THIS
func remove_projectile(projectile:Node) -> void:
	if ProjectileChecks.check_if_this_a_projectile(projectile):
		_remove_projectile_step_2(projectile)

## EDIT THIS
func _remove_projectile_step_2(projectile:Node) -> void:
	check_particle_resource(projectile)
	projectile.queue_free()

func check_particle_resource(projectile:Node) -> void:
	if particle_resource != null:
		particle_resource.spawn_particle(projectile,projectile.get_parent())
