extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -2000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	position += Vector2(-10,0)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 2

	# Handle Jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY


	move_and_slide()


func _on_enemy_death_area_area_entered(area):
	if area.name == "player":
		Global.SCORE += 1
		queue_free()
		#signal to make new wall
		Global.WALLRESET.emit()
		


func _on_enemy_player_area_entered(area):
	if area.name == "player":
		print("quitGame")
