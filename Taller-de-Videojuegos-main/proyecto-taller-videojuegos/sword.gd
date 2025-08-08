extends Node3D

@onready var swordhitbox = $HitboxSword
var mundo = 0
var player = 0
var hand = 0
signal throw

func _ready():
	mundo = get_node("/root/main")
	player= get_node("/root/main/CharacterBody3D")
	hand = get_node("/root/main/CharacterBody3D/Hand")

func _process(delta):
	if Input.is_action_just_pressed("throw"):
		self.get_parent().remove_child(self)
		mundo.add_child(self)
		self.position = player.position + hand.position
		emit_signal("throw")
