extends Control


func _on_singleplayer_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Interface/singleplayer_menu.tscn")

func _on_multiplayer_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Interface/multiplayer_menu.tscn")
