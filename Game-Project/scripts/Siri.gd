extends CharacterBody2D  # Usando Area2D

const SPEED = 1800.0

@onready var animation: AnimationPlayer = $Sprite2D/Animation
@onready var ray = $Ray

@export var direction := -10

signal hit_player  # Sinal que será emitido quando o personagem colidir com o inimigo
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if ray.is_colliding():
		direction *= -1
		ray.scale.x *= -1
		flip()

	if direction:
		velocity.x = direction * SPEED * delta

	move_and_slide()

func flip():
	if velocity.x < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false

func _on_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Verifica se o corpo que entrou na área é o personagem
		print("Player colidiu com o inimigo!")
		#emit_signal("hit_player")  # Emite o sinal de colisão com o personagem
		if GameManager:
			print("Chamando reset_game no GameManager...")
			GameManager.reset_game()
		else:
			print("GameManager não encontrado!")
