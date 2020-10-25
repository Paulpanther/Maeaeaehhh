extends Area2D

export var up_impulse = 1000
export var side_angle_variation = 30

func _on_entered(body: RigidBody2D):
	body.apply_impulse(Vector2(0, 0), _get_random_impulse())
	body.get_node("BoomSound").play_effect()

func _get_random_impulse():
	var angle = (randf() - 0.5) * 2 * side_angle_variation
	return Vector2.UP.rotated(deg2rad(angle)) * up_impulse
