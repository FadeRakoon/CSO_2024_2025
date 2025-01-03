class_name DataTypes

enum Tools{
	None,
	AxeWood,
	TillGrass,
	SelectSeeds,
	WaterCrops,
	Build,
}

#used to assign names to action values

static var tool_dmg: Dictionary = {
	1: 1,
}
#used to assign damage values to tools
#expandable if we choose to get more tools (currently limited by asset pack)
