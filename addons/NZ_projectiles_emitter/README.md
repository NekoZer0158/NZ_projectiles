# NZ projectiles emitter
Emit projectiles from plugin NZ_projectiles.
REQUIRES: NZ_projectiles

## Emitters
### 2D
	Projectile_emitter2D_base - base for every 2D emitter
	PE2D_simple - the simplest projectile emitter, just put the scene with a projectile and emit or set instantly_emit to true
	PE2D_ID - get projectile by ID from the dictionary in the specific node and emit it
	PE2DID_line - emit projectile from any point on the line (experimental)
### 3D
	Projectil_emitter3D_Base - base for every 3D emitter
	PE3D_simple - the simplest projectile emitter, just put the scene with a projectile and emit or set instantly_emit to true
	PE3D_ID - get projectile by ID from the dictionary in the specific node and emit it
	PE3DID_line - emit any projectile from the 2D line in 3D space (experimental)

## Changelog
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
