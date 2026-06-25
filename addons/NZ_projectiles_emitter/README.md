# NZ projectiles emitter
Emit projectiles from the plugin NZ_projectiles.
REQUIRES: NZ_projectiles.

## Emitters
### 2D
	Projectile_emitter2D_base - base for every 2D emitter.
	PE2D_simple - the simplest projectile emitter, just put the scene with a projectile and emit or set instantly_emit to true.
	PE2D_ID - get projectile by ID from the dictionary in the specific node and emit it.
	PE2DID_line - emit projectile from any point on the line (experimental).
	PE2DID_slider - emit projectile from any point of slider/any tick/dragger of a Slider.
	PE2DID_Hslider - emit projectile from any point of slider/any tick/dragger of a VSlider.
	PE2DID_Vslider - emit projectile from any point of slider/any tick/dragger of a HSlider.
### 3D
	Projectil_emitter3D_Base - base for every 3D emitter.
	PE3D_simple - the simplest projectile emitter, just put the scene with a projectile and emit or set instantly_emit to true.
	PE3D_ID - get projectile by ID from the dictionary in the specific node and emit it.
	PE3DID_line - emit any projectile from the 2D line in 3D space (experimental).
### Other
	Emitter_ammo - adds ammo and reloading systems to an emitter.

## Changelog
## 1.6.1 (Small Fix)
	Fix Emitter_ammo when max_ammo_in_magazine is set to -1 ammo didn't spend at all.
## 1.6 (Neo Projectiles)
	Add Emitter_spread_shot_base, Emitter2D_spread_shot and Emitter3D_spread_shot - shoot multiple projectiles with one emit and different angles.
	Add Emitter_toggle - allows you to shoot projectiles in a row with a time between shots
	Add Emitter_related_node - the parent class of Emitter_ammo.
	Now you can select how PE2D_ID will get projectiles, through a variable or a function in another node.
	Fix bug when you could emit with 0 ammo if you set it in the inspector.
### 1.5 (Mega Projectiles)
	Add can_emit - if set to false then you can't use emit().
	Add signal projectile_was_emitted.
	Add Emitter_ammo - a node that adds ammo system and reloading, needs to be added as a child to Projectile_emitter2D_base or Projectile_emitter3D_base or any of their subclasses.
	Add new_life_time to Projectile_emitter3D_base.
### 1.4 (Projectiles Symphony)
	Updates now have names.
	Add PE2DID_slider, PE2DID_Hslider and PE2DID_Vslider to emit projectiles from VSlider and HSlider (experimental).
	Add new_life_time in Projectile_emitter2D_base to change projectile's life time before emitting.
	Fix _check_replacers in Projectile_emitter2D_base.
### 1.3
	Add PE3DID_line, emit any projectile from the 2D line in 3D space
	Add replacers to Projectile_emitter3D_base and Projectile_emitter2D_base, with them you can replace a certain module in a projectile with a different one
	Add debug to Projectile_emitter3D_base and Projectile_emitter2D_base
	Change error_if_there_is_nod_id to error_if_there_is_no_id in PE2D_ID and PE3D_ID
### 1.2
	Added 3D emitters
### 1.1
	Added PE2DID_line, with it you can emit projectile from any point on the line
	Added new argument to emit function - type, with which you can set type to the projectile when emitting it
	Projectiles will have the same rotation as the emitter, except PE2DID_line
	Added icons
### 1.0
	Release
