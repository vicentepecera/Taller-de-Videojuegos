extends Node3D

var mundo
var player
var hand
var launching
var lastdirectionlaunch
var skin
var camera
var launchingtoy



func _ready():
	mundo = get_node("/root/main")
	player= get_node("/root/main/CharacterBody3D")
	hand = get_node("/root/main/CharacterBody3D/skin/Hand")
	skin = get_node("/root/main/CharacterBody3D/skin")
	camera = get_node("/root/main/CharacterBody3D/SpringArmPivot/Camera3D")
	$HitboxSword.connect("hit", Callable(self, "on_hit"))
	
func on_hit():
	launching = false
	
func _process(delta):
	if Input.is_action_just_pressed("throw"):
		if not launching:
			launchingtoy = min(0,camera.global_position.y)
			var actualrotation = skin.rotation
			lastdirectionlaunch = player.lastdirection
			self.get_parent().remove_child(self)
			mundo.add_child(self)
			self.position = hand.global_position
			self.rotation = actualrotation
			self.rotate_object_local(Vector3(1, 0, 0), deg_to_rad(-90))
			launching = true
		else:
			player.position = self.position
			self.get_parent().remove_child(self)
			hand.add_child(self)
			self.position = Vector3(0,0,0)
			self.rotation = Vector3(0,0,0)
			launching = false
	if launching == true:
		self.position += lastdirectionlaunch*0.7
		self.position.y -= launchingtoy
		self.rotate_object_local(Vector3(0, 1, 0), deg_to_rad(-10))
