#if defined _converter_included
	#endinput
#endif
#define _converter_included
#pragma library converter

// MTA -> SAMP Map Converter v1.0 by kurta999

enum EConvertingFlags
{
	ONLY_CREATE_VEHICLE = 1, // There will be no special data converted ex paintjob, interior and mods. Only CreateVehicle() line
	CONVERT_NUMBER_PLATE = 2, // Convert vehicle number plate?
	HIDE_WHEN_ALPHA_NOT_255 = 4, // If you change the object alpha value different than 255, then hide object in samp? Its useful if you want to create invisible objects in samp
	CONVERT_ELEMENT_NAME = 8, // Convert the name of the element which you give to the element in MTA, useful if you want to find specific model after conversion
	NO_PAWN_CALLS = 16, // Disable calling pawn functions - On_X_DataConverted. OnConvertationStart and OnConvertationFinish ALWAYS will be called
};

enum EMapType
{
	MTA_RACE = 0,
	MTA_DM = 1,
};

native ConvertMTAMapFile(path[], EConvertingFlags:flags);
native SetMapVehiclesRespawn(time);
native GetMapVehiclesRespawn();

forward OnConvertationStart(mapname[], EMapType:maptype);
forward OnConvertationFinish(mapname[], EMapType:maptype, flags, objects, removeobjects, vehicles, checkpoints, pickups);
forward OnObjectDataConverted(modelid, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ, interior, virtualworld);
forward OnRemoveObjectDataConverted(modelid, Float:fX, Float:fY, Float:fZ, Float:fRadius);
forward OnVehicleDataConverted(modelid, Float:fX, Float:fY, Float:fZ, Float:fAngle, color1, color2, paintjob, upgrades[], plate[], interior, virtualworld);
forward OnCheckpointDataConverted(type[], Float:fX, Float:fY, Float:fZ, Float:fSize, interior, virtualworld);
forward OnPickupDataConverted(modelid, Float:fX, Float:fY, Float:fZ, virtualworld);

