@icon("res://addons/NZ_projectiles_emitter/Icons/Other/Emitter_toggle.svg")
class_name Emitter_toggle
extends Emitter_related_node

## @experimental
## Allows you to shoot projectiles in a row with a time between shots.[br][color=green]Requires:[/color] [Timer] as a child of this node, timeout will be autmotacially connected to the _on_timer_timeout.

@export var toggled : bool = false
@export var func_name_to_call : String = "emit" ## There should be a name for a function that will be called every time_between_shots

var other_emitter_toggles : Array[Emitter_toggle]

var timer : Timer

func _ready() -> void:
	super()
	for i in get_children():
		if i is Timer:
			timer = i
			break
	if !is_instance_valid(timer):
		push_error("No valid timer was found")
		queue_free()
	for i in _emitter.get_children():
		if i is Emitter_toggle:
			other_emitter_toggles.append(i)
	if !_emitter.has_method(func_name_to_call):
		push_error("func with name ",func_name_to_call," doesn't exists in the emitter ",_emitter.name)
		queue_free()
	if toggled:
		toggle_on()

func change_toggle_mode(toggled_on:bool,...args:Array) -> void:
	if toggled_on:
		callv(&"toggle_on",args)
	else:
		toggle_off()

func toggle_on(...args:Array) -> void:
	toggled = true
	for i in other_emitter_toggles:
		i.toggle_off()
	timer.start()
	timer.timeout.connect(_on_timer_timeout.bind(args))
	callv(&"_call_func_in_emitter",args)

func toggle_off() -> void:
	toggled = false
	if timer.timeout.is_connected(_on_timer_timeout):
		timer.timeout.disconnect(_on_timer_timeout)
	timer.stop()

func _call_func_in_emitter(...args:Array) -> void:
	if !args.is_empty():
		_emitter.callv(func_name_to_call,args)
	else:
		_emitter.call(func_name_to_call)

func _on_timer_timeout(args:Array) -> void:
	callv(&"_call_func_in_emitter",args)
