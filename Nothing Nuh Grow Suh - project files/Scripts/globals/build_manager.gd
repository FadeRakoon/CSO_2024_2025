extends Node

var selected_build: DataTypes.Builds = DataTypes.Builds.None

signal build_selected(build: DataTypes.Builds)

func select_build(build: DataTypes.Builds) -> void:
	build_selected.emit(build)
	selected_build = build
