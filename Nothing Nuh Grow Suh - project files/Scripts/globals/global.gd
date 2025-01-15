extends Node

var plant_inventory = {
	DataTypes.Plants.Tomato: 0,
	DataTypes.Plants.Corn: 0,
	DataTypes.Plants.Onion: 0, 
	DataTypes.Plants.Carrot: 0, 
	DataTypes.Plants.Potato: 0, 
	DataTypes.Plants.Callaloo: 0,
	DataTypes.Plants.Pumpkin: 0,
	
}

var coin: int =  50#stores the coin value

const BURN_POLLUTION = 10
const BURN_FERTILITY = 15
const PLANT_WATER_LOSS = -3
const PLANT_FERTILITY_LOSS = -2
const PLANT_FERTILITY_GAIN = 3
