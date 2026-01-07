extends Projectile_custom

func a_func_to_test(args) -> void:
	print("This was added in 2.5")
	print(args)
	queue_free()
