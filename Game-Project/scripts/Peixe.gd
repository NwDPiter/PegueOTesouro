extends CharacterBody2D

@export var speed := 100
@onready var sprite = $Sprite2D
@onready var raycast = $Ray
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

var direction := -1  # começa andando para a esquerda

func _physics_process(delta):
	# Verifica se há chão à frente com o RayCast2D
	if not raycast.is_colliding():
		direction *= -1  # inverte a direção
		sprite.flip_h = direction > 0  # vira o sprite
		raycast.position.x *= -1  # move o raycast junto

	# Move o personagem
	velocity.x = direction * speed
	move_and_slide()

	# Animação de movimento
	if animation_player.current_animation != "run":
		animation_player.play("run")

func _on_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Verifica se o corpo que entrou na área é o personagem
		print("Player colidiu com o inimigo!")
		#emit_signal("hit_player")  # Emite o sinal de colisão com o personagem
		if GameManager:
			print("Chamando reset_game no GameManager...")
			GameManager.reset_game()
		else:
			print("GameManager não encontrado!")
