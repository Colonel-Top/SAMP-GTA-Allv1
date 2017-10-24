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
new PlayerText:TDAPACHE[MAX_PLAYERS];
new PlayerText:TDAPACHE2[MAX_PLAYERS];
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
		            printf("%d",freshv[playerid]);
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
                     		PlayerTextDrawSetString(playerid,TDAPACHE2[playerid], typingstring2);
						    /*GameTextForPlayer(playerid,"~r~Your missile is empty please wait to reload !",2000,3);
							SendClientMessage(playerid,COLOR_RED,"Your Missile is reloading Do not fired until reload finish !");
							
							SetTimerEx("announce", 100, false, "i", playerid);*/
						}
					}
					else if(playerammo[playerid] <= hunterammo)
					{
                    	
					 format(typingstring,sizeof(typingstring),"Missile : %d",freshv[playerid]);
                     PlayerTextDrawSetString(playerid,TDAPACHE[playerid], typingstring);
                  
					 playerammo[playerid] ++;
					}
				}
			

		}
	}
	if (PRESSED(KEY_ACTION))
	{
if (IsPlayerInAnyVehicle(playerid))
		{

		        if (phydra[playerid] == true)
		        {
					freshvv[playerid] = hydraammo-playerammo[playerid];

		            phunter[playerid]=false;
		           printf("%d",freshvv[playerid]);
		        	if(playerammo[playerid] > hydraammo)
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
                     		PlayerTextDrawSetString(playerid,TDAPACHE2[playerid], typingstring2);
						    /*GameTextForPlayer(playerid,"~r~Your missile is empty please wait to reload !",2000,3);
							SendClientMessage(playerid,COLOR_RED,"Your Missile is reloading Do not fired until reload finish !");

							SetTimerEx("announce", 100, false, "i", playerid);*/
						}
					}
					else if(playerammo[playerid] <= hydraammo)
					{

					 format(typingstring,sizeof(typingstring),"Missile : %d",freshvv[playerid]);
                     PlayerTextDrawSetString(playerid,TDAPACHE[playerid], typingstring);

					 playerammo[playerid] ++;
					}
				}


		}
	}
/*
            	if (PRESSED(KEY_FIRE) || PRESSED(KEY_ACTION))
		{/*
		    new weapons[32];
		    new sr[32];
		    
		    weapons[16]= GetPlayerWeapon(playerid);
		    format(sr,sizeof(sr),"Weapon ID %d",weapons);
			printf("%d",sr);
		    if (IsPlayerInAnyVehicle(playerid))
			{

		        if (prhino[playerid] == true)
		        {

		            phunter[playerid]=false;
		            phydra[playerid]=false;
					if(tankfired[playerid]==false)
					{
					    tankfired[playerid]=true;
					}
					if(tankfired[playerid]==true)
					{
					    TogglePlayerControllable(playerid,0);
						SetTimerEx("stopfreeze", 2000, false, "i", playerid);
						if(isreload[playerid] == true)
						{
							SetTimerEx("reload",reloadtime, false, "i", playerid);

						}
						else
						{
						    isreload[playerid] = true;
							format(string2,sizeof(string2),"Status : Reloading");
                     		PlayerTextDrawSetString(playerid,TDAPACHE2[playerid], string2);
	  					}
					}
		        	
		        }
			}
		}
  /*
		if (HOLDING(KEY_ACTION))
		{
		    if (IsPlayerInAnyVehicle(playerid))
			{

		        if (prhino[playerid] == true)
		        {

		            phunter[playerid]=false;
		            phydra[playerid]=false;

		        	if(sspfired[playerid] > overheattime)
		        	{
						TogglePlayerControllable(playerid,0);
						SetTimerEx("stopfreeze", 100, false, "i", playerid);

						//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     					if(isreload[playerid] == true)
						{
							SetTimerEx("reheat",reloadtime, false, "i", playerid);

						}
						else
						{
						    isreload[playerid] = true;
							format(string3,sizeof(string3),"Status : Cooling Down");
                     		PlayerTextDrawSetString(playerid,TDAPACHE2[playerid], string3);
						    /*GameTextForPlayer(playerid,"~r~Your missile is empty please wait to reload !",2000,3);
							SendClientMessage(playerid,COLOR_RED,"Your Missile is reloading Do not fired until reload finish !");

							SetTimerEx("announce", 100, false, "i", playerid);*
						}
						/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					}
					else if(sspfired[playerid] <= overheattime)
					{


                     PlayerTextDrawSetString(playerid,TDAPACHE[playerid], "Gatling Gun");
                    	sspfired[playerid]+= 100;

					}
		        }
			}
		}*/
	return 1;
}
//=================================================forward & public zone=================================================//
/*
forward announce(playerid);
public announce(playerid)
{
	GameTextForPlayer(playerid,"~r~RELOADING...",reloadtime-200,3);
	return 1;
}
forward reheat(playerid);
public reheat(playerid)
{
    isreload[playerid] = false;
    TogglePlayerControllable(playerid,1);
    sspfired[playerid] = 0;
    
    format(string3,sizeof(string3),"Status : Reloaded ");
   	PlayerTextDrawSetString(playerid,TDAPACHE2[playerid], string3);
	return 1;
}*/
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
   	PlayerTextDrawSetString(playerid,TDAPACHE2[playerid], typingstring2);
	return 1;
}
//===============================================system public zone=======================================================//
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(GetVehicleModel(vehicleid) == 425) // you can changed to jet tank or anything else that need reload ! note: if u want more u need to define new variables
	{
	    phunter[playerid] = true;

	format(typingstring,sizeof(typingstring),"Missile : %d",freshv[playerid]);
                     PlayerTextDrawSetString(playerid,TDAPACHE[playerid], typingstring);
                     format(typingstring2,sizeof(typingstring2),"Status : Reloaded ");
                     		PlayerTextDrawSetString(playerid,TDAPACHE2[playerid], "Status : Reloaded" );

   PlayerTextDrawShow(playerid, TDAPACHE[playerid]);


	PlayerTextDrawShow(playerid, TDAPACHE2[playerid]);

	}
	if(GetVehicleModel(vehicleid) == 520) // you can changed to jet tank or anything else that need reload ! note: if u want more u need to define new variables
	{
	
	    phydra[playerid] = true;
	   
	    

	format(typingstring,sizeof(typingstring),"Missile : %d",freshvv[playerid]);
                     PlayerTextDrawSetString(playerid,TDAPACHE[playerid], typingstring);
                     format(typingstring2,sizeof(typingstring2),"Status : Reloaded ");
                     		PlayerTextDrawSetString(playerid,TDAPACHE2[playerid], "Status : Reloaded" );
 PlayerTextDrawShow(playerid, TDAPACHE[playerid]);
 	PlayerTextDrawShow(playerid, TDAPACHE2[playerid]);
	}/*
	if(GetVehicleModel(vehicleid) == 432)
	{
		prhino[playerid] = true;
		TDAPACHE[playerid] = CreatePlayerTextDraw(playerid,487.000000, 333.000000, "");
	PlayerTextDrawBackgroundColor(playerid,TDAPACHE[playerid], 255);
	PlayerTextDrawFont(playerid,TDAPACHE[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDAPACHE[playerid], 0.500000, 1.800000);
	PlayerTextDrawColor(playerid,TDAPACHE[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDAPACHE[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDAPACHE[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDAPACHE[playerid], 1);
	PlayerTextDrawUseBox(playerid,TDAPACHE[playerid],1);
   PlayerTextDrawShow(playerid, TDAPACHE[playerid]);

	TDAPACHE2[playerid] = CreatePlayerTextDraw(playerid,487.000000, 360.000000, "");

	PlayerTextDrawBackgroundColor(playerid,TDAPACHE2[playerid], 255);
	PlayerTextDrawFont(playerid,TDAPACHE2[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDAPACHE2[playerid], 0.500000, 1.800000);
	PlayerTextDrawColor(playerid,TDAPACHE2[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDAPACHE2[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDAPACHE2[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDAPACHE2[playerid], 1);
	PlayerTextDrawUseBox(playerid,TDAPACHE2[playerid],1);
	PlayerTextDrawShow(playerid, TDAPACHE2[playerid]);

                    format(string,sizeof(string),"Main 60MM");
                     PlayerTextDrawSetString(playerid,TDAPACHE[playerid], string);
                     format(string2,sizeof(string2),"Status : Reloaded");
                     		PlayerTextDrawSetString(playerid,TDAPACHE2[playerid], string2);
	}*/
	return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(GetVehicleModel(vehicleid) == 425)
    {
         phunter[playerid] = false;
         PlayerTextDrawHide(playerid,TDAPACHE[playerid]);
         PlayerTextDrawHide(playerid,TDAPACHE2[playerid]);
    }
    if(GetVehicleModel(vehicleid) == 520)
    {
        PlayerTextDrawHide(playerid,TDAPACHE[playerid]);
         PlayerTextDrawHide(playerid,TDAPACHE2[playerid]);
         phydra[playerid] = false;
    }/*
    if(GetVehicleModel(vehicleid) == 432)
    {
        PlayerTextDrawHide(playerid,TDAPACHE[playerid]);
         PlayerTextDrawHide(playerid,TDAPACHE2[playerid]);
         prhino[playerid] = false;
    }*/
	return 1;
}
public OnPlayerSpawn(playerid)
{
    
    phunter[playerid] = false;
    phydra[playerid] = false;
         prhino[playerid] = false;
         freshv[playerid] = hunterammo-playerammo[playerid];
    freshvv[playerid] = hydraammo-playerammo[playerid];
    sspfired[playerid] = 0;
    playerammo[playerid] = 0;
    PlayerTextDrawHide(playerid,TDAPACHE[playerid]);
         PlayerTextDrawHide(playerid,TDAPACHE2[playerid]);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    freshv[playerid] = hunterammo-playerammo[playerid];
     freshvv[playerid] = hydraammo-playerammo[playerid];
	 phunter[playerid] = false;
    phydra[playerid] = false;
     prhino[playerid] = false;
    sspfired[playerid] = 0;
    PlayerTextDrawHide(playerid,TDAPACHE[playerid]);
         PlayerTextDrawHide(playerid,TDAPACHE2[playerid]);
	return 1;
}
public OnPlayerConnect(playerid)
{
   
    	     TDAPACHE[playerid] = CreatePlayerTextDraw(playerid,487.000000, 333.000000, "");
	PlayerTextDrawBackgroundColor(playerid,TDAPACHE[playerid], 255);
	PlayerTextDrawFont(playerid,TDAPACHE[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDAPACHE[playerid], 0.500000, 1.800000);
	PlayerTextDrawColor(playerid,TDAPACHE[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDAPACHE[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDAPACHE[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDAPACHE[playerid], 1);
	PlayerTextDrawUseBox(playerid,TDAPACHE[playerid],1);
		TDAPACHE2[playerid] = CreatePlayerTextDraw(playerid,487.000000, 360.000000, "");

	PlayerTextDrawBackgroundColor(playerid,TDAPACHE2[playerid], 255);
	PlayerTextDrawFont(playerid,TDAPACHE2[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDAPACHE2[playerid], 0.500000, 1.800000);
	PlayerTextDrawColor(playerid,TDAPACHE2[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDAPACHE2[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDAPACHE2[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDAPACHE2[playerid], 1);
	PlayerTextDrawUseBox(playerid,TDAPACHE2[playerid],1);
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
