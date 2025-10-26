class_name ProjectileGetter
extends RefCounted

static func get_cur_basis_axis(cur_basis_axis:ProjectileEnum.BasisAxis,projectile3D:Projectile3D) -> Vector3:
	match cur_basis_axis:
		ProjectileEnum.BasisAxis.X:
			return projectile3D.transform.basis.x
		ProjectileEnum.BasisAxis.Y:
			return projectile3D.transform.basis.y
		ProjectileEnum.BasisAxis.Z:
			return projectile3D.transform.basis.z
	return Vector3.ZERO
