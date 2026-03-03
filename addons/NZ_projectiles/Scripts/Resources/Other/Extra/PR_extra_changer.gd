@icon("res://addons/NZ_projectiles/Icons/Other/Extra/PR_extra_changer.svg")
class_name PR_extra_changer
extends Projectile_resource_extra

@export var new_resource : Projectile_resource
@export var change_this : ProjectileEnum.ProjectileModuleNames
@export var duplicate_resource : bool = false

func use_extra() -> void:
	match change_this:
		ProjectileEnum.ProjectileModuleNames.ATK_CHANGE:
			if duplicate_resource:
				projectile.r_atk_change = new_resource.duplicate(true)
			else:
				projectile.r_atk_change = new_resource
		ProjectileEnum.ProjectileModuleNames.SPEED_CHANGE:
			if duplicate_resource:
				projectile.r_speed_change = new_resource.duplicate(true)
			else:
				projectile.r_speed_change = new_resource
		ProjectileEnum.ProjectileModuleNames.MOVE_EXTENDED:
			if duplicate_resource:
				projectile.r_move_extended = new_resource.duplicate(true)
			else:
				projectile.r_move_extended = new_resource
		ProjectileEnum.ProjectileModuleNames.HIT_EXTENDED:
			if duplicate_resource:
				projectile.r_hit_extended = new_resource.duplicate(true)
			else:
				projectile.r_hit_extended = new_resource
		ProjectileEnum.ProjectileModuleNames.REMOVE:
			if duplicate_resource:
				projectile.r_remove_projectile = new_resource.duplicate(true)
			else:
				projectile.r_remove_projectile = new_resource
	if new_resource.has_method("_ready"):
		new_resource._ready(projectile)
	if projectile.r_speed_change != null and projectile.r_speed_change == new_resource:
		projectile.r_speed_change.activate()
