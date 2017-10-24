#include <a_samp>
#include <converter>
#include <streamer>

// Remove this if you do not want to create converted elements ingame - Töröld ha nem akarok megjeleníteni a játékban a kovnertált dolgokat
#define CREATE_CONVERTED_ELEMENTS

public OnFilterScriptInit()
{
    ConvertMTAMapFile("scriptfiles\\maps", CONVERT_ELEMENT_NAME);
	return 1;
}

public OnConvertationStart(mapname[], EMapType:maptype)
{
	//printf("objdata: %s - %s", mapname, (maptype == MTA_RACE) ? ("Race") : ("DM"));
	return 1;
}

public OnConvertationFinish(mapname[], EMapType:maptype, flags, objects, removeobjects, vehicles, checkpoints, pickups)
{
	//printf("objdata end: %s - %s", mapname, (maptype == MTA_RACE) ? ("Race") : ("DM"));
	return 1;
}

public OnObjectDataConverted(modelid, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ, interior, virtualworld)
{
	#if defined CREATE_CONVERTED_ELEMENTS
	CreateDynamicObject(modelid, fX, fY, fZ, fRotX, fRotY, fRotZ, virtualworld, interior);
	#endif

//	printf("OnObjectDataConverted(modelid = %d, fX = %.2f, fY = %.2f, fZ = %.2f, fRotX = %.2f, fRotY = %.2f, fRotZ = %.2f, interior = %d, virtualworld = %d)", modelid, fX, fY, fZ, fRotX, fRotY, fRotZ, interior, virtualworld);
	return 1;
}

public OnRemoveObjectDataConverted(modelid, Float:fX, Float:fY, Float:fZ, Float:fRadius)
{
	#if defined CREATE_CONVERTED_ELEMENTS
	for(new i; i != MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i)) continue;
		RemoveBuildingForPlayer(i, modelid, fX, fY, fZ, fRadius);
	}
	#endif

//	printf("OnRemoveObjectDataConverted(modelid = %d, fX = %.2f, fY = %.2f, fZ = %.2f, fRadius = %.2f)", modelid, fX, fY, fZ, fRadius);
	return 1;
}

public OnVehicleDataConverted(modelid, Float:fX, Float:fY, Float:fZ, Float:fAngle, color1, color2, paintjob, upgrades[], plate[], interior, virtualworld)
{
	//printf("OnVehicleDataConverted(modelid = %d, fX = %.2f, fY = %.2f, fZ = %.2f, fAngle = %.2f, color1 = %d, color2 = %d, paintjob = %d, plate[] = %s, interior = %d, virtualworld = %d", modelid, fX, fY, fZ, fAngle, color1, color2, paintjob, plate, interior, virtualworld);
	new vid = CreateVehicle(modelid, fX, fY, fZ, fAngle, color1, color2, GetMapVehiclesRespawn());
	LinkVehicleToInterior(vid, interior);
	SetVehicleVirtualWorld(vid, virtualworld);
	if(paintjob < 3) ChangeVehiclePaintjob(vid, paintjob);

	for(new i; i != 14; i++)
	{
		if(!upgrades[i]) continue;
		//printf("upgrades[%d] = %d", i, upgrades[i]);
		AddVehicleComponent(vid, upgrades[i]);
	}
	return 1;
}

public OnCheckpointDataConverted(type[], Float:fX, Float:fY, Float:fZ, Float:fSize, interior, virtualworld)
{
	#if defined CREATE_CONVERTED_ELEMENTS
	if(!strcmp(type, "checkpoint"))
	{
		CreateDynamicCP(fX, fY, fZ, fSize);
	}
	else if(!strcmp(type, "cylinder"))
	{
		CreateDynamicRaceCP(4, fX, fY, fZ, 0.0, 0.0, 0.0, fSize);
	}
	else if(!strcmp(type, "ring"))
	{
        CreateDynamicRaceCP(2, fX, fY, fZ, 0.0, 0.0, 0.0, fSize);
	}
	#endif
	return 1;
}

public OnPickupDataConverted(modelid, Float:fX, Float:fY, Float:fZ, virtualworld)
{
	#if defined CREATE_CONVERTED_ELEMENTS
	CreateDynamicPickup(modelid, 2, fX, fY, fZ);
	#endif
	return 1;
}
