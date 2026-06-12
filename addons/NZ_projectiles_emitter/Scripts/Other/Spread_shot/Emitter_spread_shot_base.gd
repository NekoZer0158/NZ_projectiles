@abstract
class_name Emitter_spread_shot_base
extends Emitter_related_node

@export var min_amount : int = 5
@export var max_amount : int = 10

func _ready() -> void:
	super()
	if min_amount < 0:
		push_error("min_amount must be a non negative number")
		queue_free()
	if max_amount < 0:
		push_error("max_amount must be a non negative number")
		queue_free()
	_emitter.add_projectile_instance_to_scene = false
	_emitter.projectile_was_emitted.connect(_make_projectiles_spread)

func _get_projectile_instance(projectile:Node) -> Node:
	return projectile.duplicate()

func _make_projectiles_spread(projectile:Node) -> void:
	var projectile_instances : Array[Node]
	var amount_of_projectiles : int = randi_range(min_amount,max_amount)
	if amount_of_projectiles == 0:
		projectile.queue_free()
		return
	for i in range(0,amount_of_projectiles-1):
		var new_projectile_instance := _get_projectile_instance(projectile)
		_change_projectile_variables(new_projectile_instance)
		projectile_instances.append(new_projectile_instance)
	_change_projectile_variables(projectile)
	projectile_instances.append(projectile)
	if _emitter.add_child_to_this_node == null:
		for i in projectile_instances:
			add_child(i)
	else:
		for i in projectile_instances:
			_emitter.add_child_to_this_node.call_deferred(&"add_child",i)

@abstract
func _change_projectile_variables(projectile:Node) -> void
