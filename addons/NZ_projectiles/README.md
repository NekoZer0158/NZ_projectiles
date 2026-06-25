# NZ projectiles
Plugin for Godot that adds a projectile system in 2D&3D. There are four projectile classes (2 each for 2D & 3D), base one and extended, to which you can add more stuff, like changing speed every second or making it disappear only after interacting with 3 objects.

## Changelog

### 2.10.1 (Small fix)
	Move_projectile_on_line2D will now show error if it can't find a node with line_path.
	If debug is set to true in Move_projectile_on_line2D then will be printed when _cur_line is set to null through _set_cur_line_to_null().
	Fix calling _ready() in the wrong resource in PR_extra_changer.
### 2.10 (Neo Projectiles)
	Update Move_to_node3D_projectile, now includes reach_distance, extra_resource, and when extra_resource will be activated.
	extra_timer_path can only be set to Timer in Move_to_node2D_projectile.
	Change use_extra() in Projectile_resource_extra, now it requires a projectile node as an argument and the projectile variable in Projectile_resource_extra is now deprecated.
	Add add_to_position in RP_spawn_projectile to change spawned projectile position.
	Add instant_look and look_speed in Move_projectile_on_line2D, Move_projectile_on_path3D, Move_to_node2D_projectile and Move_to_node3D_projectile
	Add find_shortest_way_to_angle() in Move_extended_projectile and Move_extended_projectile3D
	Improve PR_extra_change_var, now you can select what to do with a new value, replace the old value, add to it or subtract from it.
	In Move_projectile_on_path3D and Move_projectile_on_line2D clamp() was changed to clampi() and wrap() to wrapi().
	In Move_direction_projectile3D,Move_direction_projectile and RP_spawn_projectile clamp() was changed to clampf().
	type is now export_storage
	Add more comments.
	Some fixes in comments.
	Update documentation
	Update NZ_projectiles_emitter to 1.6.
### 2.9 (Mega Projectiles)
	Add PR_extra_change_var - change any variable in a projectile.
	Update Move_to_node2D_projectile, now includes reach_distance, extra_resource, and when extra_resource will be activated
	Hit_extended_projectile is now not an abstact class. This is made to use extra_resource without giving more arguments.
	Change Hit_extended_projectile and HE_other icons.
	Now if Move_projectile_on_line2D is used then the projectile will use a duplicate of it.
	Update NZ_projectiles_emitter to 1.5.
### 2.8 (Projectiles Symphony)
	Updates now have names.
	There is now a separate showcase scene for emitters, 2D & 3D projectiles for 2.8 update (and will be for every future update).
	Add Projectile_resource_extra - use to call it in other projectile modules.
	Add PR_extra_changer - replace any module in Projectile_extended or Projectile3D_extended.
	Add PR_extras - change multiple modules at once.
	Update SC_condition and Hit_extended_projectile to include Projectile_resource_extra that will be activated after fulfilling the condition.
	Update AC_time to include Projectile_resource_extra that will be activated after atk is reached the required value.
	Update Hit_extended_projectile to include Projectile_resource_extra that will be activated after attacking anything.
	Update Move_to_node2D and Move_to_node3D, now you can set it to move away from Node2D, multiply to scale when the projectile doesn't look at Node2D or if there is no Node2D to switch to default movement.
	Add icons to SC_increase_func and ProjectileEnum.
### 2.7
	Add Move_projectile_on_line2D
	Add Move_projectile_on_path3D
	Add check_ready_function_in_resources in Projectile_extended and Projectile3D_extended to enable/disable activationg of _ready() function in modules in node's _ready() function
	Add Atk_change_func - change atk using a function, but now without a timer
	Now you can set node2D_path in Move_to_node2D_projectile and node3D_path in Move_to_node3D_projectile manually through inspector
	Add small descriptions for all Remove_projectile, Move_extended_projectile, Atk_change_projectile, Hit_extended_projectile and Move_extended_projectile3D resources
	cur_basis_axis in Move_to_node3D_projectile is now set to ProjectileEnum.BasisAxis.Z
	Documentation is moved to the separate folder
### 2.6
	Add debug to SC_increase and SC_condition to have an easier time finding bugs
	Add SC_increase_func - increase speed by calling a function in a different resource
	Improve SC_reset and HE_other
	Update HE_more_variables
	Fix ACT_func
	Update NZ_projectiles_emitter to 1.3 (check README in NZ_projectile_emitter to see what was changed)
	Update NZ_projectiles_custom to Experimental 0.3 (E 0.3) (check README in NZ_projectiles_custom to see what was changed)
	Check Update_2_6 scene to see new stuff (you can get this in NZ_projectiles folder via GitHub)
### 2.5
	Move Projectile_custom and its resources to the separate plugin NZ_projectiles_custom
	Add icon for Projectile_resource
	Add ACT_func - change atk by calling a function in a resource
### 2.4
	Added Projectile_custom - a new projectile class (this is not a subclass for Projectile), it has much more customization than Projectile_extended. The idea is to give you an ability to make what you want without coding. EXPERIMENTAL
	Added Projectile_custom_resource - a resource for Projectile_custom. EXPERIMENTAL
	Added Update_2_4 scene
### 2.3
	Added Update_2_3 scene
	Added RP_multiple - activate multiple Remove_projectile resources at once
	Added RP_other and HE_other - activate a function in a different Projectile_resource
	All projectile resoucres are a subclass of Projectile_resource instead of Resource
	NZ_projectiles_emitter updated to 1.2
### 2.2
	Added Update_2_2 scene
	NZ_projectiles_emitter updated to 1.1
	Some fixes in Update_2_1 scene
### 2.1
	Added RP_group (Remove every projectile in the group)
	Added PaPr_random (Random particle on every call of the function)
	Added new plugin - NZ_projectiles_emiitter
### 2.0
	Added 3D support
	Changed ID from int to String.
	Moved ID from Projectile_extended to Projectile
	Changed some functions names to include _ in them, also removed deprecated function
	Removed clamp functions from SC_random_range
