@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Multiple.svg")
class_name RP_multiple
extends Remove_projectile

@export var RP_resources : Array[Remove_projectile]
@export var push_error_if_resource_is_null : bool = true

func remove_projectile(projectile:Projectile) -> void:
	for i in RP_resources:
		if i != null:
			i.remove_projectile(projectile)
		elif push_error_if_resource_is_null:
			push_error("resource is null")
	check_particle_resource(projectile)
