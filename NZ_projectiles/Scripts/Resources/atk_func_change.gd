extends Resource

var test_2 : String = "testing stuff"
## (atk*atk_step)-minus_this
@export var minus_this : int = 1


func change_atk(atk:int,atk_step:int) -> int:
	return (atk*atk_step)-minus_this
