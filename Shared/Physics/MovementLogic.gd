extends Node

static func follow(velocity: Vector2, globalP: Vector2, targetP: Vector2, speed: int) -> Vector2:
	var desired_velocity: = (targetP - globalP).normalized() * speed
	var steering: = (desired_velocity - velocity) / 2
	return velocity + steering
