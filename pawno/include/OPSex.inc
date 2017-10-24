//OnPlayerSpawn Ex - by Romel

#include <a_samp>

#define FIRST_SPAWN 0
#define	SEC_SPAWN   1
#define RESPAWN     2

#define IsPlayerSpawned(%0) varSpawn[%0]

/*
native IsPlayerSpawned(playerid);
native SetPlayerToRespawn(playerid);
*/

new varSpawn[MAX_PLAYERS] = FIRST_SPAWN;

forward OnPlayerSpawnEx(playerid, hasspawned);


stock SetPlayerToRespawn(playerid)
{
	SetPlayerHealth(playerid, 0.0);
	varSpawn[playerid] = RESPAWN;
	return 1;
}

public OnPlayerConnect(playerid)
{
	varSpawn[playerid] = FIRST_SPAWN;
	return 1;
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect OPSex_OnPlayerConnect

forward OPSex_OnPlayerConnect(playerid);

public OnPlayerSpawn(playerid)
{
    CallLocalFunction("OnPlayerSpawnEx", "dd", playerid, varSpawn[playerid]);
    varSpawn[playerid] = SEC_SPAWN;
    return 1;
}

#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn OPSex_OnPlayerSpawn

forward OPSex_OnPlayerSpawn(playerid);