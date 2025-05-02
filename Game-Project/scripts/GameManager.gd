extends Node
var bau_coletado := 0

func reset_game():
	print("Reset iniciado pelo GameManager!")
	var current_scene = get_tree().current_scene
	var player = current_scene.get_node("Player")
	# Resetar playerd 
	if player:
		player.reset_game()
		var hud = current_scene.get_node("Hud")  # substitua "HUD" pelo nome real do CanvasLayer
		if hud:
			hud.reset()


	# Resetar baús
	#for bau in current_scene.get_tree().get_nodes_in_group("baus"):
	#	bau.resetar()
# Resetar baús com verificação de método
	for bau in current_scene.get_tree().get_nodes_in_group("baus"):
		if bau.has_method("resetar"):
			bau.resetar()
		else:
			print("Nó no grupo 'baus' não tem método 'resetar':", bau)
