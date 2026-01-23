extends Resource

@export var plus_this : int = 2
@export var minus_this : int = 3

func test_speed_change(cur_speed:int,step:int) -> int:
	return (cur_speed+step)+plus_this-minus_this
