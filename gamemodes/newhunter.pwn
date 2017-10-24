//===================================================================

#include <a_samp>
#pragma tabsize 0
#include <zcmd>
//==============================variable=========================================================//
new bool:phunter[MAX_PLAYERS];
new bool:phydra[MAX_PLAYERS];
new bool:prhino[MAX_PLAYERS];
new playerammo[MAX_PLAYERS];
//new texthunterformat[32];
new freshv[MAX_PLAYERS];
new freshvv[MAX_PLAYERS];
new bool:isreload[MAX_PLAYERS];
new sspfired[MAX_PLAYERS];
new bool:tankfired[MAX_PLAYERS];
//================================TD/////////////////////////////
new PlayerText:TDHUNTER[MAX_PLAYERS];
new PlayerText:TDHUNTER2[MAX_PLAYERS];
static typingstring[64];
static typingstring2[86];

//=================================COLOR DEFINE=================================================//
#define COLOR_RED 0xAA3333AA
//===============================define your value here=========================================//
//new    bool:HoldingKey[MAX_PLAYERS];
#define hunterammo 14 //ammo missile of hunter
#define reloadtime 5000 //Time to relaod in Millisecond
#define hydraammo 12
#define overheattime 5000 //Time to reload in Millisecond
//================================define key press fired==========================================//
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
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
		            
		            phydra[playerid]=false;
		            freshv[playerid] = hunterammo-playerammo[playerid];
		            print(freshv[playerid]);
		        	if(playerammo[playerid] > hunterammo)
		        	{
						TogglePlayerControllable(playerid,0);
						SetTimerEx("stopfreeze", 100, false, "i", playerid);
						
						
						if(isreload[playerid] == true)
						{
							SetTimerEx("reload",reloadtime, false, "i", playerid);
						    playerammo[playerid] =50;
						}
						else if(isreload[playerid] == false)
						{
						    isreload[playerid] = true;
							format(typingstring2,sizeof(typingstring2),"Status : Reloading !");
                     		PlayerTextDrawSetString(playerid,TDHUNTER2[playerid], typingstring2);
						    /*GameTextForPlayer(playerid,"~r~Your missile is empty please wait to reload !",2000,3);
							SendClientMessage(playerid,COLOR_RED,"Your Missile is reloading Do not fired until reload finish !");
							
							SetTimerEx("announce", 100, false, "i", playerid);*/
						}
					}
					else if(playerammo[playerid] <= hunterammo)
					{
                    	
					 format(typingstring,sizeof(typingstring),"Missile : %d",freshv[playerid]);
                     PlayerTextDrawSetString(playerid,TDHUNTER[playerid], typingstring);
                  
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
    isreload[playerid] = false;
    TogglePlayerControllable(playerid,1);
    playerammo[playerid] = 0;
    freshv[playerid] = hunterammo-playerammo[playerid];
    freshvv[playerid] = hydraammo-playerammo[playerid];
    tankfired[playerid] = false;
    format(typingstring2,sizeof(typingstring2),"Status : Reloaded !");
   	PlayerTextDrawSetString(playerid,TDHUNTER2[playerid], typingstring2);
	return 1;
}
//===============================================system public zone=======================================================//
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(GetVehicleModel(vehicleid) == 425) // you can changed to jet tank or anything else that need reload ! note: if u want more u need to define new variables
	{
	    phunter[playerid] = true;

	format(typingstring,sizeof(typingstring),"Missile : %d",freshv[playerid]);
                     PlayerTextDrawSetString(playerid,TDHUNTER[playerid], typingstring);
                     format(typingstring2,sizeof(typingstring2),"Status : Reloaded ");
                     		PlayerTextDrawSetString(playerid,TDHUNTER2[playerid], "Status : Reloaded" );

   PlayerTextDrawShow(playerid, TDHUNTER[playerid]);


	PlayerTextDrawShow(playerid, TDHUNTER2[playerid]);

	}
	return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(GetVehicleModel(vehicleid) == 425)
    {
         phunter[playerid] = false;
         PlayerTextDrawHide(playerid,TDHUNTER[playerid]);
         PlayerTextDrawHide(playerid,TDHUNTER2[playerid]);
    }
    if(GetVehicleModel(vehicleid) == 520)
    {
        PlayerTextDrawHide(playerid,TDHUNTER[playerid]);
         PlayerTextDrawHide(playerid,TDHUNTER2[playerid]);
         phydra[playerid] = false;
    }
	return 1;
}
public OnPlayerSpawn(playerid)
{
    
    phunter[playerid] = false;
   // phydra[playerid] = false;
        // prhino[playerid] = false;
         freshv[playerid] = hunterammo-playerammo[playerid];
    //freshvv[playerid] = hydraammo-playerammo[playerid];
   // sspfired[playerid] = 0;
    playerammo[playerid] = 0;
    PlayerTextDrawHide(playerid,TDHUNTER[playerid]);
         PlayerTextDrawHide(playerid,TDHUNTER2[playerid]);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    freshv[playerid] = hunterammo-playerammo[playerid];
     //freshvv[playerid] = hydraammo-playerammo[playerid];
	 phunter[playerid] = false;
   // phydra[playerid] = false;
    // prhino[playerid] = false;
    //sspfired[playerid] = 0;
    PlayerTextDrawHide(playerid,TDHUNTER[playerid]);
         PlayerTextDrawHide(playerid,TDHUNTER2[playerid]);
	return 1;
}
public OnPlayerConnect(playerid)
{
   
    	     TDHUNTER[playerid] = CreatePlayerTextDraw(playerid,487.000000, 333.000000, "");
	PlayerTextDrawBackgroundColor(playerid,TDHUNTER[playerid], 255);
	PlayerTextDrawFont(playerid,TDHUNTER[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDHUNTER[playerid], 0.500000, 1.800000);
	PlayerTextDrawColor(playerid,TDHUNTER[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDHUNTER[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDHUNTER[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDHUNTER[playerid], 1);
	PlayerTextDrawUseBox(playerid,TDHUNTER[playerid],1);
		TDHUNTER2[playerid] = CreatePlayerTextDraw(playerid,487.000000, 360.000000, "");

	PlayerTextDrawBackgroundColor(playerid,TDHUNTER2[playerid], 255);
	PlayerTextDrawFont(playerid,TDHUNTER2[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDHUNTER2[playerid], 0.500000, 1.800000);
	PlayerTextDrawColor(playerid,TDHUNTER2[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDHUNTER2[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDHUNTER2[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDHUNTER2[playerid], 1);
	PlayerTextDrawUseBox(playerid,TDHUNTER2[playerid],1);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}
CMD:freezeme(playerid,params[])
{
	TogglePlayerControllable(playerid,0);
	return 1;
}
CMD:unfreezeme(playerid,params[])
{
	TogglePlayerControllable(playerid,1);
	return 1;
}
