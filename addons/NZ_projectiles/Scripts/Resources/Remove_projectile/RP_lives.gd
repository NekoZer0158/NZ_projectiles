@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Lives.svg")
class_name RP_lives
extends Remove_projectile

@export var hits_before_removing : int = 3
@export var next_phase : Remove_projectile
@export var use_particle_every_hit : bool = false

const CREATE_DUPLICATE :int = 1

func remove_projectile(projectile:Projectile) -> void:
	hits_before_removing -= 1
	if (use_particle_every_hit and hits_before_removing > 0) or (hits_before_removing == 0 and next_phase != null):
		check_particle_resource(projectile)
	if hits_before_removing <= 0:
		if next_phase != null:
			if hits_before_removing <= 0:
				if hits_before_removing < 0 or next_phase is not RP_lives:
					next_phase.remove_projectile(projectile)
		else:
			check_particle_resource(projectile)
			projectile.queue_free()
