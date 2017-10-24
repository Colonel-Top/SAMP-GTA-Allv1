/*
	© Gamer931215
	This script allows to detect deathmatching vehicles and disable them when needed
*/

//includes/defines
#include <a_samp>
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
forward OnPlayerVehicleFire(playerid,vehicleid,allowed);
	
/*
	These natives are commented to "fake" the natives for providing autocomplete when included
	native ToggleVehicleWeaponsForAll()
	native ToggleVehicleWeaponsForPlayer(playerid)
*/


//local variables
new filter[] = {
	447,    //seasparrow
	476,	//rustler
	425,	//hunter
	520,	//hydra
	430,    //predator
	432     //rhino
};
new DisableForAll = 1;

//public functions
stock ToggleVehicleWeaponsForAll(toggle)
{
	if(toggle == 1)
	{
		DisableForAll = 0;
	} else DisableForAll = 1;
}

stock ToggleVehicleWeaponsForPlayer(playerid,toggle)
{
    SetPVarInt(playerid,"__allowed",toggle);
}

stock CanPlayerShootInVehicle(playerid)
{
    if(DisableForAll == 0)
    {
        return true;
    } else {
		if(GetPVarInt(playerid,"__allowed") == 1)
		{
			return true;
		}
    }
    return false;
}

// SA-MP Default functions:

public OnPlayerUpdate(playerid)
{
	new keys,updown,leftright;
	GetPlayerKeys(playerid,keys,updown,leftright);
	if(IsPlayerInArmedVehicle(playerid))
	{
	    switch(GetVehicleModel(GetPlayerVehicleID(playerid)))
	    {
	        case 447,476,520: //vehicles with only one weapon
	        {
			    if(keys & KEY_ACTION)
			    {
				    if(GetPVarInt(playerid,"__shot") == 0)
					{
						SetPVarInt(playerid,"__shot",1);
						CallLocalFunction("OnPlayerVehicleFire","iii",playerid,GetPlayerVehicleID(playerid),CanPlayerShootInVehicle(playerid));
						return 0;
					}
			    }
	        }
	        default: //all the other vehicles in filter (use KEY_ACTION and KEY_FIRE)
	        {
			    if(keys & KEY_ACTION || keys & KEY_FIRE) //respond to primary and secondary fire key (like hunter)
			    {
				    if(GetPVarInt(playerid,"__shot") == 0)
					{
						SetPVarInt(playerid,"__shot",1);
						CallLocalFunction("OnPlayerVehicleFire","iii",playerid,GetPlayerVehicleID(playerid),CanPlayerShootInVehicle(playerid));
						return 0;
					}
			    }
	        }
	    }
	}
	return CallLocalFunction("nodmforu_OnPlayerUpdate","i",playerid);
}
#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate nodmforu_OnPlayerUpdate
forward nodmforu_OnPlayerUpdate(playerid);

public OnPlayerConnect(playerid)
{
    SetPVarInt(playerid,"__shot",0);
    if(DisableForAll == 1)
    {
        SetPVarInt(playerid,"__allowed",0);
    } else SetPVarInt(playerid,"__allowed",1);
    return CallLocalFunction("nodmforu_OnPlayerConnect","i",playerid);
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect nodmforu_OnPlayerConnect
forward nodmforu_OnPlayerConnect(playerid);

public OnPlayerDisconnect(playerid)
{
	DeletePVar(playerid,"__shot");
	DeletePVar(playerid,"__allowed");
	return CallLocalFunction("nodmforu_OnPlayerDisconnect","i",playerid);
}
#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect nodmforu_OnPlayerDisconnect
forward nodmforu_OnPlayerDisconnect(playerid);

public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
	if (!(newkeys & KEY_FIRE) && (oldkeys & KEY_FIRE)) //player released fire key
	{
		SetPVarInt(playerid,"__shot",0);
  	}
	if (!(newkeys & KEY_ACTION) && (oldkeys & KEY_ACTION)) //player released fire key
	{
		SetPVarInt(playerid,"__shot",0);
	}
	return CallLocalFunction("nodmforu_OnPlayerKeyStateChange","iii",playerid,newkeys,oldkeys);
}
#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange nodmforu_OnPlayerKeyStateChange
forward nodmforu_OnPlayerKeyStateChange(playerid,newkeys,oldkeys);

stock IsPlayerInArmedVehicle(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    for(new i = 0;i<strlen(filter);i++)
	    {
	        if(filter[i] == GetVehicleModel(GetPlayerVehicleID(playerid)))
	        {
	            return true;
	        }
	    }
	}
	return false;
}
