@tool
@icon("res://addons/NZ_projectiles/Icons/Other/PaPr_random.svg")
class_name PaPr_random
extends Particle_projectile

@export var particle_scenes : Array[PackedScene]
@export var random_amount : int = -1: ## -1 = infinite
	set(value):
		random_amount = clamp(value,-1,abs(value))

func _get_particle_instance() -> Node:
	if random_amount > 0 or random_amount == -1:
		random_amount -= 1
		return particle_scenes.pick_random().instantiate()
	return super()
