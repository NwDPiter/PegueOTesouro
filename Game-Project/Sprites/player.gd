extends CharacterBody2D

@export var speed = 250.0
@export var jump_velocity = 380.0

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: float


@export var start_position := Vector2(45.0, 468.0)  # Posição inicial do personagem
@onready var baus = $"../Hud/Baus"



# Função que será chamada quando o personagem colidir com o inimigo
func reset_game():
	# Reposiciona o personagem para a posição inicial
	position = start_position
	# Aqui você pode adicionar outras ações, como tocar uma animação de morte ou reiniciar a cena.
	print("Jogo reiniciado! Reposicionando o personagem.")
	
func _process(_delta):
	animate()
	fliph()
	
func fliph():
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	if velocity.x < 0:
		$Sprite2D.flip_h = true
		
func animate():
	if velocity.y > 0 and not is_on_floor():
		animation.play("fall")    
	elif velocity.y < 0 and not is_on_floor():
		animation.play("jump")
	elif velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")

func _physics_process(delta):
	gravidade(delta)
	mover()
	
func _input(_event: InputEvent):
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jump()
	direction = Input.get_axis("Esquerda", "Direita")
	
func mover():
	velocity.x = direction * speed
	move_and_slide()
	
func gravidade(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
	
func jump():
	velocity.y = -jump_velocity

# Função que lida com a colisão do inimigo
#func _on_Inimigo_body_entered(body):
#	if body.is_in_group("player"):  # Verifica se o corpo é o personagem
#		reset_game()  # Chama a função de reset do personagem

func _ready():
	for inimigo in get_tree().get_nodes_in_group("inimigos"):
		inimigo.connect("hit_player", Callable(self, "reset_game"))
		reset_game()
