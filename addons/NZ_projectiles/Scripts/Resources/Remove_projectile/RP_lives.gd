@icon("res://addons/NZ_projectiles/Icons/Remove_projectile/Lives.svg")
class_name RP_lives
extends Remove_projectile

## Removes 1 life after every hit, when lives hit 0 the projectile will be removed

@export var hits_before_removing : int = 3
@export var next_phase : Remove_projectile ## After hits_before_removing becomes 0, the projectile will start using next_phase (example: after hitting 3 objects, the projectile will spawn another projectile)
@export var use_particle_every_hit : bool = false

var _default_hits_before_removing : int

const CREATE_DUPLICATE : bool = true

func _remove_projectile_step_2(projectile:Node) -> void:
	if _default_hits_before_removing == 0:
		_default_hits_before_removing = hits_before_removing
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
