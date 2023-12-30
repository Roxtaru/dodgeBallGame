extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -1500.0
var wall = preload("res://scenes/wallNode.tscn")
var enemy = preload("res://scenes/enemyNode.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	Global.connect("WALLRESET", Callable(self, "wallReset"))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0

	# Handle Jump.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text = str(Global.SCORE)


func jumpFunc():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY


func _on_jump_button_pressed():
	jumpFunc()

func wallReset():
	if randi() % 2 == 0 :
		var wallInstance = wall.instantiate()
		wallInstance.position = Vector2(2105, randi_range(992,1792))
		get_parent().call_deferred("add_child", wallInstance)
	else:
		var enemyInstance = enemy.instantiate()
		enemyInstance.position = Vector2(2105, 960)
		get_parent().call_deferred("add_child", enemyInstance)

func _on_resetter_area_entered(area):
	if area.name == "wallArea" or area.name == "enemyDeathArea":
		area.queue_free()
		wallReset()
