@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Default.svg")
class_name Remove_projectile
extends Projectile_resource

## Just removes projectile with queue_free()

@export var particle_resource : Particle_projectile
#var object_pooling : bool = false ## Use it only if you are gonna use an object pool. Enabling this will just disable and hide the projectile instead of queue_free it. I recommend enabling this through code in the emitter from NZ_projectiles_emitter or from your own emitter implementation

signal projectile_needs_to_be_removed(projectile:Node) ## Connect this function to your object pool. projectile is [Projectile] or [Projectile3D].

## DON'T EDIT THIS
func remove_projectile(projectile:Node) -> void:
	if ProjectileChecks.check_if_this_a_projectile(projectile):
		_remove_projectile_step_2(projectile)

## EDIT THIS
func _remove_projectile_step_2(projectile:Node) -> void:
	check_particle_resource(projectile)
	projectile.queue_free()

#func _remove_projectile_free_or_pool(projectile:Node) -> void:
	#if !object_pooling:
		#projectile.queue_free()
	#else:
		#projectile.hide()
		#projectile.process_mode = Node.PROCESS_MODE_DISABLED
		#projectile.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_OFF
		#projectile_needs_to_be_removed.emit(projectile)
		#projectile.get_parent().remove_child(projectile)

func check_particle_resource(projectile:Node) -> void:
	if particle_resource != null:
		particle_resource.spawn_particle(projectile,projectile.get_parent())
