@icon("res://addons/NZ_projectiles/Icons/Other/Particle_projectile.svg")
class_name Particle_projectile
extends Resource

@export var particle_scene : PackedScene
@export var make_particle_look_backwards : bool = true

func spawn_particle(projectile:Projectile,add_to_this_node:Node) -> void:
	var spawn_this_particle := particle_scene.instantiate()
	if spawn_this_particle is CPUParticles2D or spawn_this_particle is GPUParticles2D:
		spawn_this_particle.global_position = projectile.global_position
		spawn_this_particle.emitting = true
		add_to_this_node.add_child(spawn_this_particle)
		if make_particle_look_backwards:
			spawn_this_particle.look_at(projectile.global_position-projectile.speed*projectile.transform.x)
	else:
		push_error("Wrong scene")
