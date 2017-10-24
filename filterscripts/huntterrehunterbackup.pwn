//===================================================================

#include <a_samp>
#pragma tabsize 0
//==============================variable=========================================================//
new bool:phunter[MAX_PLAYERS];
new playerammo[MAX_PLAYERS];
new texthunterformat[32];
new bool:isreload[MAX_PLAYERS];
new freshv[MAX_PLAYERS];
new PlayerText:TextDraw0[MAX_PLAYERS];
new PlayerText:TextDraw1[MAX_PLAYERS];
static hunterstring[64];
static hunterstatus[32];
//=================================COLOR DEFINE=================================================//
#define COLOR_RED 0xAA3333AA
//===============================define your value here=========================================//

#define hunterammo 50 //ammo missile of hunter
#define reloadtime 5000 //Time to relaod in Millisecond

//================================define key press fired==========================================//
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
//=================================System FS zone==================================================//
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Hunter Ammo By Colonel-Top (Promsurin Putthammawong)Loaded!");
	print("--------------------------------------\n");

	return 1;
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
	print(" Hunter Ammo By Colonel-Top (Promsurin Putthammawong)Unloaded!");
	print("--------------------------------------\n");
	return 1;
}
//================================= Playerkeystatechanged zone==================================================//
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (PRESSED(KEY_FIRE))
	{

		if (IsPlayerInAnyVehicle(playerid))
		{

		        if (phunter[playerid] == true)
		        {
		            freshv[playerid] = hunterammo-playerammo[playerid];
		        	if(playerammo[playerid] > hunterammo)
		        	{

						TogglePlayerControllable(playerid,0);
						SetTimerEx("stopfreeze", 100, false, "i", playerid);
						if(isreload[playerid] == true)
						{
						
						SetTimerEx("reload",reloadtime, false, "i", playerid);
							   
						}
						else if(isreload[playerid] == false)
						{
						    GameTextForPlayer(playerid,"~y~Your Missile are ~r~Empty ~n~~p~Please Wait To ~r~Reload !",2000,3);
						SendClientMessage(playerid,COLOR_RED,"Your Missile is reloading");
						//
						 format(hunterstring,sizeof(hunterstring),"Missile: %d",freshv[playerid]);
						PlayerTextDrawSetString(playerid,TextDraw0[playerid],hunterstring);
						format(hunterstatus,sizeof(hunterstatus),"Status: Reloading");
						PlayerTextDrawSetString(playerid,TextDraw1[playerid],hunterstatus);
						isreload[playerid] = true;
						}
					}
					else if(playerammo[playerid] <= hunterammo)
					{

					 format(texthunterformat,sizeof(texthunterformat),"~g~Missile Left : ~y~ %d",freshv[playerid]);
					 GameTextForPlayer(playerid,texthunterformat,1200,3);
					 playerammo[playerid] ++;
					}
				}

		}
	}
	return 1;
}
//=================================================forward & public zone=================================================//
forward stopfreeze(playerid);
public stopfreeze(playerid)
{
    TogglePlayerControllable(playerid,1);
	return 1;
}
forward reload(playerid);
public reload(playerid)
{
	isreload[playerid]=false;
    TogglePlayerControllable(playerid,1);
    playerammo[playerid] = 0;
    freshv[playerid] = hunterammo-playerammo[playerid];
    	    format(hunterstring,sizeof(hunterstring),"Missile: %d",freshv[playerid]);
PlayerTextDrawSetString(playerid,TextDraw0[playerid],hunterstring);
format(hunterstatus,sizeof(hunterstatus),"Status: Reloaded");
PlayerTextDrawSetString(playerid,TextDraw1[playerid],hunterstatus);
    //GameTextForPlayer(playerid,"~r~Missile Reload!",1200,3);
	return 1;
}
//===============================================system public zone=======================================================//
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(GetVehicleModel(vehicleid) == 425) // you can changed to jet tank or anything else that need reload ! note: if u want more u need to define new variables
	{
	    phunter[playerid] = true;
	    format(hunterstring,sizeof(hunterstring),"Missile: %d",freshv[playerid]);
PlayerTextDrawSetString(playerid,TextDraw0[playerid],hunterstring);
format(hunterstatus,sizeof(hunterstatus),"Status: Reloaded");
PlayerTextDrawSetString(playerid,TextDraw1[playerid],hunterstatus);
PlayerTextDrawShow(playerid, TextDraw0[playerid]);
PlayerTextDrawShow(playerid, TextDraw1[playerid]);
	}
	return 1;
}
public OnPlayerSpawn(playerid)
{
    phunter[playerid] = false;
    playerammo[playerid] = 0;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	phunter[playerid] = false;
}
public OnPlayerConnect(playerid)
{
    TextDraw0[playerid] = CreatePlayerTextDraw(playerid,487.000000, 333.000000,"");
PlayerTextDrawBackgroundColor(playerid,TextDraw0[playerid], 255);
PlayerTextDrawFont(playerid,TextDraw0[playerid], 1);
PlayerTextDrawLetterSize(playerid,TextDraw0[playerid], 0.500000, 1.799999);
PlayerTextDrawColor(playerid,TextDraw0[playerid], -1);
PlayerTextDrawSetOutline(playerid,TextDraw0[playerid], 0);
PlayerTextDrawSetProportional(playerid,TextDraw0[playerid], 1);
PlayerTextDrawSetShadow(playerid,TextDraw0[playerid], 1);

TextDraw1[playerid] = CreatePlayerTextDraw(playerid,487.000000, 360.000000, "");
PlayerTextDrawBackgroundColor(playerid,TextDraw1[playerid], 255);
PlayerTextDrawFont(playerid,TextDraw1[playerid], 1);
PlayerTextDrawLetterSize(playerid,TextDraw1[playerid], 0.500000, 1.799999);
PlayerTextDrawColor(playerid,TextDraw1[playerid], -1);
PlayerTextDrawSetOutline(playerid,TextDraw1[playerid], 0);
PlayerTextDrawSetProportional(playerid,TextDraw1[playerid], 1);
PlayerTextDrawSetShadow(playerid,TextDraw1[playerid], 1);
	return 1;
	
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(GetVehicleModel(vehicleid) == 425)
    {
         phunter[playerid] = false;
         PlayerTextDrawHide(playerid,TextDraw1[playerid]);
         PlayerTextDrawHide(playerid,TextDraw0[playerid]);
    }
    return 1;
}
