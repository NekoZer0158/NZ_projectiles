extends Resource

func change_atk_2_7(atk:int,other_values:Array[Variant]) -> int:
	if other_values.is_empty():
		return atk
	var extra_vector : Vector2 = other_values.front()
	if typeof(extra_vector) == TYPE_VECTOR2:
		return int(atk*extra_vector.x-extra_vector.y)
	return atk
