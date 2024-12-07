@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Default.svg")
class_name Remove_projectile
extends Resource

@export var particle_resource : Particle_projectile

func remove_projectile(projectile:Projectile) -> void:
	check_particle_resource(projectile)
	projectile.queue_free()

func check_particle_resource(projectile:Projectile) -> void:
	if particle_resource != null:
		particle_resource.spawn_particle(projectile,projectile.get_parent())
