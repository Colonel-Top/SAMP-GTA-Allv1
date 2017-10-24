/*
Filterscript generated using Zamaroht's TextDraw Editor Version 1.0.
Designed for SA-MP 0.3a.

Time and Date: 2015-1-7 @ 13:31:1

Instructions:
1- Compile this file using the compiler provided with the sa-mp server package.
2- Copy the .amx file to the filterscripts directory.
3- Add the filterscripts in the server.cfg file (more info here:
http://wiki.sa-mp.com/wiki/Server.cfg)
4- Run the server!

Disclaimer:
You have full rights over this file. You can distribute it, modify it, and
change it as much as you want, without having to give any special credits.
*/

#include <a_samp>
#include <dini>
#include <sscanf2>
#include <dudb>
#define COLOR_BLUE 0x0000BBAA
static Float:x, Float:y, Float:z;
#define SERVER_USER_FILE "AFadmin/Users/%s.ini"
new PlayerText:TDKILL[MAX_PLAYERS];
new PlayerText:TDDEATH[MAX_PLAYERS];
new PlayerText:TDRANK[MAX_PLAYERS];
new PlayerText:TDSCORE[MAX_PLAYERS];
new PlayerText:TDWARN[MAX_PLAYERS];
new PlayerText:TDPMSTATUS[MAX_PLAYERS];
new PlayerText3D:label;
static form0[64],form10[64],form2[64],form3[64],form4[64],form5[64];//,form6[32];
enum gPlayerInfos
{
	LoggedIn,
	Register,
	Level,
	Muted,
	Kills,
	Death,
	Spawned,
	Hours,
 	Mins,
 	Secs,
 	Warnings,
 	Spec,
 	FailLogin,
	Kicked,
	Banned,
	Password,
	RPK,
	Money,
	Score,
	Skin,
	SkinStatus,
	savepos,
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	interior,
	sex,
	age,
	team,
	Jail,
	ArmyLevel,
	pmstatus,
 Hungry
};
new PlayerInfos[MAX_PLAYERS][gPlayerInfos];
public OnFilterScriptInit()
{

	// Create the textdraws:

	return 1;
}

public OnFilterScriptExit()
{

	return 1;
}

public OnPlayerConnect(playerid)
{
{
	TDKILL[playerid] = CreatePlayerTextDraw(playerid,37.000000, 115.000000, "Kill");
	PlayerTextDrawBackgroundColor(playerid,TDKILL[playerid], 255);
	PlayerTextDrawFont(playerid,TDKILL[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDKILL[playerid], 0.500000, 1.899999);
	PlayerTextDrawColor(playerid,TDKILL[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDKILL[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDKILL[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDKILL[playerid], 1);

	TDDEATH[playerid] = CreatePlayerTextDraw(playerid,37.000000, 143.000000, "Death");
	PlayerTextDrawBackgroundColor(playerid,TDDEATH[playerid], 255);
	PlayerTextDrawFont(playerid,TDDEATH[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDDEATH[playerid], 0.500000, 1.899999);
	PlayerTextDrawColor(playerid,TDDEATH[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDDEATH[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDDEATH[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDDEATH[playerid], 1);

	TDRANK[playerid] = CreatePlayerTextDraw(playerid,37.000000, 169.000000, "Score");
	PlayerTextDrawBackgroundColor(playerid,TDRANK[playerid], 255);
	PlayerTextDrawFont(playerid,TDRANK[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDRANK[playerid], 0.500000, 1.899999);
	PlayerTextDrawColor(playerid,TDRANK[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDRANK[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDRANK[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDRANK[playerid], 1);

	TDSCORE[playerid] = CreatePlayerTextDraw(playerid,37.000000, 195.000000, "Rank");
	PlayerTextDrawBackgroundColor(playerid,TDSCORE[playerid], 255);
	PlayerTextDrawFont(playerid,TDSCORE[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDSCORE[playerid], 0.500000, 1.899999);
	PlayerTextDrawColor(playerid,TDSCORE[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDSCORE[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDSCORE[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDSCORE[playerid], 1);

	TDWARN[playerid] = CreatePlayerTextDraw(playerid,37.000000, 223.000000, "Warning");
	PlayerTextDrawBackgroundColor(playerid,TDWARN[playerid], 255);
	PlayerTextDrawFont(playerid,TDWARN[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDWARN[playerid], 0.500000, 1.899999);
	PlayerTextDrawColor(playerid,TDWARN[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDWARN[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDWARN[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDWARN[playerid], 1);

	TDPMSTATUS[playerid] = CreatePlayerTextDraw(playerid,37.000000, 252.000000, "PM Status");
	PlayerTextDrawBackgroundColor(playerid,TDPMSTATUS[playerid], 255);
	PlayerTextDrawFont(playerid,TDPMSTATUS[playerid], 1);
	PlayerTextDrawLetterSize(playerid,TDPMSTATUS[playerid], 0.500000, 1.899999);
	PlayerTextDrawColor(playerid,TDPMSTATUS[playerid], -1);
	PlayerTextDrawSetOutline(playerid,TDPMSTATUS[playerid], 0);
	PlayerTextDrawSetProportional(playerid,TDPMSTATUS[playerid], 1);
	PlayerTextDrawSetShadow(playerid,TDPMSTATUS[playerid], 1);

    //new PlayerInfos[MAX_PLAYERS][gPlayerInfos];
new name[MAX_PLAYER_NAME], file[45];
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), SERVER_USER_FILE, name);
            PlayerInfos[playerid][FailLogin]=0;
            PlayerInfos[playerid][LoggedIn] = 1;
            PlayerInfos[playerid][Level] = dini_Int(file, "Level");
             PlayerInfos[playerid][Money] = dini_Int(file, "Money");
              PlayerInfos[playerid][Score] = dini_Int(file, "Score");
            PlayerInfos[playerid][Warnings] = dini_Int(file, "Warnings");
            PlayerInfos[playerid][Hours] = dini_Int(file, "Hours");
            PlayerInfos[playerid][Mins] = dini_Int(file, "Mins");
            PlayerInfos[playerid][Secs] = dini_Int(file, "Secs");
            PlayerInfos[playerid][Muted] = dini_Int(file, "Muted");
            PlayerInfos[playerid][Kills] = dini_Int(file, "Kills");
            PlayerInfos[playerid][Death] = dini_Int(file, "Death");
            PlayerInfos[playerid][Spawned] = dini_Int(file, "Spawned");
            PlayerInfos[playerid][Spec] = dini_Int(file, "Spec");
            PlayerInfos[playerid][ArmyLevel] = dini_Int(file, "ArmyLevel");
            PlayerInfos[playerid][Skin] = dini_Int(file, "Skin");
             PlayerInfos[playerid][FailLogin] = dini_Int(file, "FailLogin");
            PlayerInfos[playerid][SkinStatus] = dini_Int(file, "SkinStatus");
             PlayerInfos[playerid][Kicked] = dini_Int(file, "Kicked");
              PlayerInfos[playerid][Banned] = dini_Int(file, "Banned");
   			PlayerInfos[playerid][Muted] = dini_Int(file, "Muted");
   				PlayerInfos[playerid][RPK] = dini_Int(file, "RPK");
	        PlayerInfos[playerid][Hours] = dini_Int(file, "Hours");
	        PlayerInfos[playerid][Mins] = dini_Int(file, "Mins");
	        PlayerInfos[playerid][Secs] = dini_Int(file, "Secs");
//			PlayerInfos[playerid][Kicked] = dini_Int(file, "Kicked");
			 PlayerInfos[playerid][interior] = dini_Int(file, "Interior");
			PlayerInfos[playerid][Jail] = dini_Int(file, "Jail");
            PlayerInfos[playerid][savepos] = dini_Int(file, "savepos");
             PlayerInfos[playerid][PosX] = dini_Float(file, "PosX");
              PlayerInfos[playerid][PosY] = dini_Float(file, "PosY");
               PlayerInfos[playerid][PosZ] = dini_Float(file, "PosZ");
            PlayerInfos[playerid][Hungry] = dini_Int(file, "Hungry");
            PlayerInfos[playerid][pmstatus] = dini_Int(file, "pmstatus");
	return 1;
	}
}
public OnPlayerSpawn(playerid)
{
       if(PlayerInfos[playerid][Score] >= 0 && PlayerInfos[playerid][Score] <= 50)
    {

		format(form2,sizeof(form2),"RANK : Pvt.");
		GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >= 51 && PlayerInfos[playerid][Score] <= 100)
    {
    	format(form2,sizeof(form2),"RANK : Pvt St.");
    	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >= 101 && PlayerInfos[playerid][Score] <= 150)
    {
    	format(form2,sizeof(form2),"RANK : Lance Cpl.");
    	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >= 151 && PlayerInfos[playerid][Score] <= 250)
    {
	   	format(form2,sizeof(form2),"RANK : Corporal");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >= 251 && PlayerInfos[playerid][Score] <= 350)
    {
	   	format(form2,sizeof(form2),"RANK : Sgt.");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >= 351 && PlayerInfos[playerid][Score] <= 500)
    {
	   	format(form2,sizeof(form2),"RANK : SSgt.");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >= 500 && PlayerInfos[playerid][Score] <= 750)
    {
	   	format(form2,sizeof(form2),"RANK : Warrant Ofc.");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >= 751 && PlayerInfos[playerid][Score] <= 1000)
    {
	   	format(form2,sizeof(form2),"RANK : C.Wrnt.Ofc.");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >= 1001 && PlayerInfos[playerid][Score] <= 1600)
    {
	   	format(form2,sizeof(form2),"RANK : S.Lt.");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >= 1601 && PlayerInfos[playerid][Score] <= 2200)
    {
	   	format(form2,sizeof(form2),"RANK : Lieutenant");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >=  2201 && PlayerInfos[playerid][Score] <= 3500)
    {
	   	format(form2,sizeof(form2),"RANK : Captain");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >=  3501 && PlayerInfos[playerid][Score] <= 4000)
    {
	   	format(form2,sizeof(form2),"RANK : Major");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >=  4001 && PlayerInfos[playerid][Score] <= 4500)
    {
	   	format(form2,sizeof(form2),"RANK : Lt.Colonel");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
		if(PlayerInfos[playerid][Score] >=  4501 && PlayerInfos[playerid][Score] <= 5000)
    {
	   	format(form2,sizeof(form2),"RANK : Colonel");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >=  5001 && PlayerInfos[playerid][Score] <= 5500)
    {
	   	format(form2,sizeof(form2),"RANK : Colonel");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >=  5601 && PlayerInfos[playerid][Score] <= 6000)
    {
	   	format(form2,sizeof(form2),"RANK : Maj.General");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >=  6001 && PlayerInfos[playerid][Score] <= 7000)
    {
	   	format(form2,sizeof(form2),"RANK : Lt.General");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >=  7001 && PlayerInfos[playerid][Score] <= 8000)
    {
	   	format(form2,sizeof(form2),"RANK : General");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
	if(PlayerInfos[playerid][Score] >=  8001 )
    {
	   	format(form2,sizeof(form2),"RANK : General of Army");
	   	GetPlayerPos(playerid,x,y,z);
        label = CreatePlayer3DTextLabel(playerid,form2,COLOR_BLUE,x,y,z+0.4,35.0,playerid,INVALID_VEHICLE_ID,0);
    	PlayerTextDrawSetString(playerid,TDRANK[playerid], form2);
	}
    format(form3,sizeof(form3),"Score : %d",PlayerInfos[playerid][Score]);
    PlayerTextDrawSetString(playerid,TDSCORE[playerid], form3);
    format(form4,sizeof(form4),"Warning : %d",PlayerInfos[playerid][Warnings]);
    PlayerTextDrawSetString(playerid,TDWARN[playerid], form4);
	if(PlayerInfos[playerid][pmstatus]==1)
	{
    	format(form5,sizeof(form5),"PM STATUS : ON");
    	PlayerTextDrawSetString(playerid,TDPMSTATUS[playerid], form5);
 	}
 		if(PlayerInfos[playerid][pmstatus]==0)
	{
    	format(form5,sizeof(form5),"PM STATUS : OFF");
    	PlayerTextDrawSetString(playerid,TDPMSTATUS[playerid], form5);
 	}
 	    format(form0,sizeof(form0),"Kills  %d ",PlayerInfos[playerid][Kills]);


    PlayerTextDrawSetString(playerid,TDKILL[playerid], form0);
    format(form10,sizeof(form10),"Deaths  %d ",PlayerInfos[playerid][Death]);
    PlayerTextDrawSetString(playerid,TDDEATH[playerid], form10);
    //
 	 printf(PlayerInfos[playerid][Kills]);
 	  printf(PlayerInfos[playerid][Death]);
 	   printf(PlayerInfos[playerid][Score]);
 	    printf(PlayerInfos[playerid][pmstatus]);
 	     printf(PlayerInfos[playerid][Warnings]);
    PlayerTextDrawShow(playerid,TDKILL[playerid]);
    PlayerTextDrawShow(playerid,TDDEATH[playerid]);
    PlayerTextDrawShow(playerid,TDRANK[playerid]);
    PlayerTextDrawShow(playerid,TDSCORE[playerid]);
    PlayerTextDrawShow(playerid,TDPMSTATUS[playerid]);
    PlayerTextDrawShow(playerid,TDWARN[playerid]);
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
PlayerTextDrawHide(playerid,TDKILL[playerid]);
    PlayerTextDrawHide(playerid,TDDEATH[playerid]);
    PlayerTextDrawHide(playerid,TDRANK[playerid]);
    PlayerTextDrawHide(playerid,TDSCORE[playerid]);
    PlayerTextDrawHide(playerid,TDPMSTATUS[playerid]);
    PlayerTextDrawHide(playerid,TDWARN[playerid]);
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	PlayerTextDrawHide(playerid,TDKILL[playerid]);
	PlayerTextDrawDestroy(playerid,TDKILL[playerid]);
	PlayerTextDrawHide(playerid,TDDEATH[playerid]);
	PlayerTextDrawDestroy(playerid,TDDEATH[playerid]);
	PlayerTextDrawHide(playerid,TDRANK[playerid]);
	PlayerTextDrawDestroy(playerid,TDRANK[playerid]);
	PlayerTextDrawHide(playerid,TDSCORE[playerid]);
	PlayerTextDrawDestroy(playerid,TDSCORE[playerid]);
	PlayerTextDrawHide(playerid,TDWARN[playerid]);
	PlayerTextDrawDestroy(playerid,TDWARN[playerid]);
	PlayerTextDrawHide(playerid,TDPMSTATUS[playerid]);
	PlayerTextDrawDestroy(playerid,TDPMSTATUS[playerid]);
	return 1;
}
