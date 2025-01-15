class_name DataTypes

#enum map{
	#None,
	#Jamaica,
	#Barbados,
	#Trinidad
#}

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
	Trees,
}

enum Builds{
	None,
}
#used to assign names to action values

static var tool_dmg: Dictionary = {
	1: 1,
	2: 1,
}
#used to assign damage values to tools
#expandable if we choose to get more tools (currently limited by asset pack)

enum Disaster{
	None,
	AcidRain,
	Flood,
}
