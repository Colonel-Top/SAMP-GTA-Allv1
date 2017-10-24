#include <a_samp>
forward IsPlayerNearPlayer(playerid, n_playerid, Float:radius);
IsPlayerNearPlayer(playerid, n_playerid, Float:radius)
{
	new Float:npx, Float:npy, Float:npz;
	GetPlayerPos(n_playerid, npx, npy, npz);
	if(IsPlayerInRangeOfPoint(playerid, radius, npx, npy, npz))
	{
		return true;
	}
	else
	{
		return false;
	}
}
