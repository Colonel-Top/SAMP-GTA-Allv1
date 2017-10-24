#include <a_samp>

public OnFilterScriptInit()
{
	print("-----------------------------------------");
	print(" Weapon Dialog by [WsR]RyDeR - Loaded - ");
	print("-----------------------------------------");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/wdialog", cmdtext, true, 12) == 0)
	{
	    ShowPlayerDialog(playerid, 8777, 2, "Weapon list", "Melee\nThrown\nPistols\nShotguns\nSub-machine guns\nRifles\nHeavy weapons\nHand held\nApparel\nSpecial", "Select", "Exit");
		return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(response == 1)
	{
	    switch(dialogid)
	    {
	        case 8777:
	    	{
	    	    switch(listitem)
	    	    {
					case 0: ShowPlayerDialog(playerid, 8778, 2, "Melee", "Brass knuckles\nGolf club\nNite stick\nKnife\nBaseball bat\nShovel\nPool cue\nKatana\nChainsaw\nPurple dildo\nShort dildo\nLong vibrator\nLong vibrator\nFlowers\nCane", "Select", "Cancel");
                	case 1: ShowPlayerDialog(playerid, 8779, 2, "Thrown", "Grenades\nTear Gas\nMolotov cocktail", "Select", "Cancel");
                	case 2: ShowPlayerDialog(playerid, 8780, 2, "Pistols", "9mm Pistol\nSilenced pistol\nDesert eagle", "Select", "Cancel");
                	case 3: ShowPlayerDialog(playerid, 8781, 2, "Shotguns", "Shotgun\nSawn-off shotgun\nCombat shotgun", "Select", "Cancel");
                	case 4: ShowPlayerDialog(playerid, 8782, 2, "Sub-machine guns", "Micro Uzi\nMP5\nTEC9", "Select", "Cancel");
                	case 5: ShowPlayerDialog(playerid, 8783, 2, "Rifles", "AK47\nM4\nCountry rifle\nSniper rifle", "Select", "Cancel");
                	case 6: ShowPlayerDialog(playerid, 8784, 2, "Heavy weapons", "Rocket Launcher\nHS-Rocket Launcher\nFlame thrower\nMinigun", "Select", "Cancel");
                	case 7: ShowPlayerDialog(playerid, 8785, 2, "Hand held", "Spray can\nFire extinguisher\nCamera", "Select", "Cancel");
                	case 8: ShowPlayerDialog(playerid, 8786, 2, "Apparel", "Night vision\nThermal goggles\nParachute", "Select", "Cancel");
               		case 9: ShowPlayerDialog(playerid, 8787, 2, "Special", "Satchel charges\nDetonator", "Select", "Cancel");
				}
			}
			case 8778:
			{
				new weapons[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
				return GivePlayerWeapon(wpid, weapons[listitem], 500);
			}
			case 8779:
			{
				new weapons[] = {16,17,18};
				return GivePlayerWeapon(wpid, weapons[listitem], 500);
			}
			case 8780:
			{
				new weapons[] = {22,23,24};
				return GivePlayerWeapon(wpid, weapons[listitem], 500);
			}
			case 8781:
			{
				new weapons[] = {25,26,27};
				return GivePlayerWeapon(wpid, weapons[listitem], 500);
			}
			case 8782:
			{
				new weapons[] = {28,29,32};
				return GivePlayerWeapon(wpid, weapons[listitem], 500);
			}
			case 8783:
			{
				new weapons[] = {30,31,33,34};
				return GivePlayerWeapon(wpid, weapons[listitem], 500);
			}
			case 8784:
			{
				new weapons[] = {35,36,37,38};
				return GivePlayerWeapon(wpid, weapons[listitem], 500);
			}
			case 8785:
			{
				new weapons[] = {41,42,43,44};
				return GivePlayerWeapon(wpid, weapons[listitem], 500);
			}
			case 8786:
			{
				new weapons[] = {44,45,46};
				return GivePlayerWeapon(wpid, weapons[listitem], 500);
			}
			case 8787:
			{
				new weapons[] = {39,40};
				return GivePlayerWeapon(wpid, weapons[listitem], 500);
			}
		}
	}
	return 1;
}
