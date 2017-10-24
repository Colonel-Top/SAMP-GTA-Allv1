/*
	PS! Thank you for downloading my Area 69 NPC Filterscript!
	          I really hope you like and enjoy it.
	          
	          
				   Please do not remove credits!
				   
						 Version 1.0 by Kiss

*/

#include <a_samp>

new RandomCar;
new Patriot1;
new Patriot2;
new Hydra;
new Cargobob;

public OnGameModeInit()
{

	// NPCS
	ConnectNPC("Soldier[BOT]","soldier");
	ConnectNPC("Soldier1[BOT]","soldier1");
	ConnectNPC("Soldier2[BOT]","soldier2");
	ConnectNPC("Soldier3[BOT]","soldier3");
	ConnectNPC("Soldier4[BOT]","soldier4");
	ConnectNPC("Soldier5[BOT]","soldier5");
	ConnectNPC("Soldier6[BOT]","soldier6");
	ConnectNPC("Soldier7[BOT]","soldier7");
	ConnectNPC("Soldier8[BOT]","soldier8");
	ConnectNPC("Soldier9[BOT]","soldier9");
	ConnectNPC("Soldier10[BOT]","soldier10");
	ConnectNPC("Soldier11[BOT]","soldier11");
	ConnectNPC("Researcher1[BOT]","researcher1");
	ConnectNPC("Researcher2[BOT]","researcher2");
	ConnectNPC("Researcher3[BOT]","researcher3");
	ConnectNPC("Researcher4[BOT]","researcher4");
	ConnectNPC("Researcher5[BOT]","researcher5");
	ConnectNPC("CarSoldier1[BOT]","carsoldier1");
	ConnectNPC("CarSoldier2[BOT]","carsoldier2");
	ConnectNPC("Hydra[BOT]","hydraman");
	ConnectNPC("Cargo[BOT]","cargobob");
	RandomCar =	AddStaticVehicle(420,2044.8854,1473.2106,10.4494,181.3339,6,1); // This shit makes sure the bot spawns. //KISS :)
	Patriot1 = AddStaticVehicle(470,193.6836,1919.7272,17.6374,180.3661,43,0); // This patriot is for patrol bot.
	Patriot2 = AddStaticVehicle(470,-11.9225,2075.1001,17.5820,181.3793,43,0); // This is also for patrol bot.
	Hydra = AddStaticVehicle(520,317.5062,2051.4451,18.3638,180.8061,0,0); // This hydra is for hydraman who flys over Area 69
	Cargobob = AddStaticVehicle(548,218.9471,1975.4169,19.2843,271.9384,1,1); // This helicopter is for cargobob pilot who patrolls over area 69
	
	// Area 69 Objects
	CreateObject(3095,268.7999900,1884.1999500,15.9000000,0.0000000,0.0000000,0.0000000); //object(a51_jetdoor) (1)
    CreateObject(3786,268.7000100,1883.8000500,-29.6000000,0.0000000,90.0000000,0.0000000); //object(missile_05_sfxr) (1)
    CreateObject(3790,262.8999900,1882.0999800,-30.1000000,0.0000000,0.0000000,90.0000000); //object(missile_01_sfxr) (1)
    CreateObject(3790,275.2999900,1859.3000500,9.0000000,0.0000000,0.0000000,0.0000000); //object(missile_01_sfxr) (2)
    CreateObject(3092,269.0000000,1858.3000500,9.0000000,90.0000000,90.0000000,90.0000000); //object(dead_tied_cop) (1)
	// Area 69 Objects
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, 0xFF8C00FF, "This server is using Area 69 NPC System by Kiss");
	//Remove that connect message if you don't want it:D
	return 1;
}


public OnPlayerSpawn(playerid)
{
    if(!IsPlayerNPC(playerid)) return 0;

	new playername[64];
	GetPlayerName(playerid,playername,64);

 	if(!strcmp(playername,"Soldier[BOT]",true)) {
 		PutPlayerInVehicle(playerid, RandomCar, 0);
 	    SetSpawnInfo( playerid, 0, 287,102.4656,1903.4524,33.8984,27.7181,0,0,0,0,0,0);
        SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Solider1[BOT]",true)) {
        PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 287,115.9793,1811.6216,17.6406,287.8707,0,0,0,0,0,0);
	    SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Soldier2[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 287,163.6118,1851.4375,33.8984,118.6694,0,0,0,0,0,0);
        SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Soldier3[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 287,160.5551,1935.0304,33.8984,30.7671,0,0,0,0,0,0); //
	    SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Soldier4[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 287,264.9125,1893.9183,33.8984,83.0207,0,0,0,0,0,0); //
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Soldier5[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 287,235.6711,1931.7489,17.8339,279.0008,0,0,0,0,0,0); //
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Soldier6[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 287,258.2573,1811.4232,22.9922,51.0374,0,0,0,0,0,0);
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Soldier7[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 287,96.4474,1922.0713,18.1312,83.1662,0,0,0,0,0,0);
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Soldier8[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 287,96.2933,1918.8005,18.1354,107.0266,0,0,0,0,0,0);
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Soldier9[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 287,210.4545,1874.9635,13.1470,288.4972,0,0,0,0,0,0);
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Soldier10[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 287,253.5164,1878.7645,11.4609,175.1417,0,0,0,0,0,0);
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Soldier11[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 287,299.9435,1820.0875,7.8205,56.6073,0,0,0,0,0,0);
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Researcher1[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 70,281.1609,1873.1881,8.7578,16.3316,0,0,0,0,0,0);
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Researcher2[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 70,271.5900,1854.0028,8.7649,179.8931,0,0,0,0,0,0);
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Researcher3[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 70,275.5670,1860.3376,8.7578,179.9399,0,0,0,0,0,0);
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Researcher4[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 70,273.8503,1881.7433,-30.3906,283.8739,0,0,0,0,0,0);
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Researcher5[BOT]",true)) {
	    PutPlayerInVehicle(playerid, RandomCar, 0);
	    SetSpawnInfo( playerid, 0, 70,263.8979,1882.4978,-30.3906,94.6423,0,0,0,0,0,0);
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"CarSoldier1[BOT]",true)) {
	    PutPlayerInVehicle(playerid, Patriot1, 0);
	    SetSpawnInfo( playerid, 0, 287, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 );
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"CarSoldier2[BOT]",true)) {
	    PutPlayerInVehicle(playerid, Patriot2, 0);
	    SetSpawnInfo( playerid, 0, 287, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 );
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Hydra[BOT]",true)) {
	    PutPlayerInVehicle(playerid, Hydra, 0);
	    SetSpawnInfo( playerid, 0, 287, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 );
		SetPlayerColor(playerid,0x33AA33AA);
	}
	else if(!strcmp(playername,"Cargo[BOT]",true)) {
	    PutPlayerInVehicle(playerid, Cargobob, 0);
	    SetSpawnInfo( playerid, 0, 287, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0 );
		SetPlayerColor(playerid,0x33AA33AA);
	}
    return 1;
}
