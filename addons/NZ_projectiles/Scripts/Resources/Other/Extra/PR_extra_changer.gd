@icon("res://addons/NZ_projectiles/Icons/Other/Extra/PR_extra_changer.svg")
class_name PR_extra_changer
extends Projectile_resource_extra

@export var new_resource : Projectile_resource
@export var change_this : ProjectileEnum.ProjectileModuleNames
@export var duplicate_resource : bool = false

func use_extra(cur_projectile:Node) -> void:
	var _cur_resource : Projectile_resource
	match change_this:
		ProjectileEnum.ProjectileModuleNames.ATK_CHANGE:
			if duplicate_resource:
				cur_projectile.r_atk_change = new_resource.duplicate(true)
			else:
				cur_projectile.r_atk_change = new_resource
			_cur_resource = cur_projectile.r_atk_change
		ProjectileEnum.ProjectileModuleNames.SPEED_CHANGE:
			if duplicate_resource:
				cur_projectile.r_speed_change = new_resource.duplicate(true)
			else:
				cur_projectile.r_speed_change = new_resource
			_cur_resource = cur_projectile.r_speed_change
		ProjectileEnum.ProjectileModuleNames.MOVE_EXTENDED:
			if duplicate_resource:
				cur_projectile.r_move_extended = new_resource.duplicate(true)
			else:
				cur_projectile.r_move_extended = new_resource
			_cur_resource = cur_projectile.r_move_extended
		ProjectileEnum.ProjectileModuleNames.HIT_EXTENDED:
			if duplicate_resource:
				cur_projectile.r_hit_extended = new_resource.duplicate(true)
			else:
				cur_projectile.r_hit_extended = new_resource
			_cur_resource = cur_projectile.r_hit_extended
		ProjectileEnum.ProjectileModuleNames.REMOVE:
			if duplicate_resource:
				cur_projectile.r_remove_projectile = new_resource.duplicate(true)
			else:
				cur_projectile.r_remove_projectile = new_resource
			_cur_resource = cur_projectile.r_remove_projectile
	if _cur_resource != null:
		if _cur_resource.has_method("_ready"):
			_cur_resource._ready(cur_projectile)
	if cur_projectile.r_speed_change != null and cur_projectile.r_speed_change == _cur_resource:
		cur_projectile.r_speed_change.activate()
