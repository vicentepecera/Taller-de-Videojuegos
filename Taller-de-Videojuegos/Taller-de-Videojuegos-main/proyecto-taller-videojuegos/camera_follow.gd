extends Camera3D

@export var spring_arm: Node3D
@export var lerp_power: float = 1.0
func _process(delta):
	position = lerp(position, spring_arm.position,delta*10*lerp_power)
