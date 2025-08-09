extends Area3D
signal hit
func _ready():
	monitoring = true
	connect("body_entered", self._on_Area_body_entered)

func _on_Area_body_entered(body):
	emit_signal("hit")
	print("Entró en área: ", body.name)
