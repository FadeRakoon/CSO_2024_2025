class_name DataTypes

enum Tools{
	None,
	AxeWood,
	BurnWood,
	TillGrass,
	PlantCrops,
	WaterCrops,
	FertilizeCrops, 
	Build,
}

enum Plants{
	None,
	Tomato,
	Corn,
	Onion, 
	Carrot, 
	Potato, 
	Callaloo,
	Pumpkin,
}

enum Builds{
	None,
}
#used to assign names to action values

static var tool_dmg: Dictionary = {
	1: 1,
}
#used to assign damage values to tools
#expandable if we choose to get more tools (currently limited by asset pack)
