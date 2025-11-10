@icon("res://addons/NZ_projectiles/Icons/Other/Particle_projectile.svg")
class_name Particle_projectile
extends Resource

@export var particle_scene : PackedScene
## ONLY IN 2D
@export var look_there : WhereToLook
@export var spawn_even_if_this_is_not_a_projectile : bool = false

enum WhereToLook{FORWARD,BACKWARD}

func spawn_particle(projectile:Node,add_to_this_node:Node) -> void:
	var spawn_this_particle : Node = _get_particle_instance()
	if spawn_this_particle is CPUParticles2D or spawn_this_particle is GPUParticles2D:
		_set_particle(spawn_this_particle,projectile,add_to_this_node)
		match look_there:
			WhereToLook.FORWARD:
				spawn_this_particle.look_at(projectile.global_position+projectile.transform.x)
			WhereToLook.BACKWARD:
				spawn_this_particle.look_at(projectile.global_position-projectile.transform.x)
	elif spawn_this_particle is CPUParticles3D or spawn_this_particle is GPUParticles3D:
		_set_particle(spawn_this_particle,projectile,add_to_this_node)
	elif spawn_even_if_this_is_not_a_projectile:
		add_to_this_node.add_child(spawn_this_particle)
	else:
		push_error("Wrong scene")

func _get_particle_instance() -> Node:
	return particle_scene.instantiate()

func _set_particle(particle:Node,projectile:Node,add_to_this_node:Node) -> void:
	particle.position = projectile.position
	particle.emitting = true
	add_to_this_node.add_child(particle)
