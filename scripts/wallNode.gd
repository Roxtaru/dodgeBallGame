extends Node2D


func _physics_process(delta):
	position += Vector2(-10,0)


func _on_score_area_body_entered(body):
	if body.name == "stickChar":
		Global.SCORE += 1
