extends Control

func _on_play_pressed() -> void:
	#get_tree().change_scene_to_file(playmenu)
	pass


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://settings.tscn")
