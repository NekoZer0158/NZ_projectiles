# NZ projectiles
Plugin for Godot that adds a projectile system in 2D&3D. There are four projectile classes (2 each for 2D & 3D), base one and extended, to which you can add more stuff, like changing speed every second or making it disappear only after interacting with 3 objects.

## Changelog

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
