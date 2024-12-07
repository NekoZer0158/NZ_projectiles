@icon("res://addons/NZ_projectiles/Icons/ProjectileChecks.svg")
class_name ProjectileChecks
extends RefCounted

const CREATE_DUPLICATE : String = "CREATE_DUPLICATE"

static func check_if_body_has_this_and_its_type(body:Node2D,this:StringName,type:int,push_error_if_there_is_no_this:bool=false) -> bool:
	if this in body:
		if typeof(body.get(this)) == type:
			return true
		push_error("Wrong type of this: ",this)
	if push_error_if_there_is_no_this:
		push_error("There is no this: ",this)
	return false

static func check_resource_if_needed_to_duplicate(projectile:Projectile,check_this:Resource,pushing_error:bool=false) -> bool:
	if check_this != null:
		if CREATE_DUPLICATE in check_this:
			return true
	elif pushing_error:
		push_error("No resource")
		projectile.queue_free()
	return false
