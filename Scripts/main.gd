extends Node


@export var player : PackedScene = preload("res://player/player.tscn")
@export var map : PackedScene
@export var scene: PackedScene

func _ready() -> void:
	print(player)
	#player = load("res://player/player.tscn")
	var upnp = UPNP.new()
	upnp.discover()
	upnp.add_port_mapping(9999)
	%PublicIP.text = upnp.query_external_address()


func _on_host_button_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(9999)
	multiplayer.multiplayer_peer = peer

	multiplayer.peer_disconnected.connect(remove_player)

	%Server.show()

	load_game()


func _on_join_button_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(%To.text, 9999)
	multiplayer.multiplayer_peer = peer

	multiplayer.connected_to_server.connect(load_game)
	multiplayer.server_disconnected.connect(connection_lost)


func _on_to_text_submitted(new_text: String) -> void:
	_on_join_button_pressed() 


func load_game():
	%Menu.hide()
	%ButtonBack.hide()
	%MapInstance.add_child(map.instantiate())
	add_player.rpc(multiplayer.get_unique_id())
	%Content.add_child(scene.instantiate())
	

func connection_lost():
	%Menu.show()

	if %MapInstance.get_child(0):
		%MapInstance.get_child(0).queue_free()


@rpc("any_peer")
func add_player(id):
	var player_instance = player.instantiate()
	player_instance.name = str(id)
	%SpawnArea.add_child(player_instance)


@rpc("any_peer")
func remove_player(id):
	if %SpawnArea.get_node(str(id)):
		%SpawnArea.get_node(str(id)).queue_free()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Interface/main_menu.tscn")
	pass # Replace with function body.
