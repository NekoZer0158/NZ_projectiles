@icon("res://addons/NZ_projectiles/Icons/Projectile_enum.svg")
class_name ProjectileEnum
extends RefCounted

enum BasisAxis{X,Y,Z}
enum ProjectileModuleNames{ATK_CHANGE,SPEED_CHANGE,MOVE_EXTENDED,HIT_EXTENDED,REMOVE}
enum AfterReachingNode{NOTHING,DEFAULT_MOVEMENT,STOP,QUEUE_FREE}
enum ExtraResourceUsageMovement{NONE,AFTER_REACHING_NODE,WHEN_NO_NODE,AFTER_REACHING_OR_WHEN_NO_NODE}
enum PointType{POINT_ZONE,DISTANCE}
