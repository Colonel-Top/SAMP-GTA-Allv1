#if !defined TDperGroup
	#define TDperGroup 25
#endif

#if !defined MAX_GROUPS
	#define MAX_GROUPS 100
#endif

/*
native CreateTDGroup({Text}:...);
native DestroyTDGroup(slot);
native TDGroupAddTD(slot,{Text}:...);
native TDGroupRemoveTD(slot,{Text}:...);
native TDGroupShowForAll(slot);
native TDGroupHideForAll(slot);
native TDGroupShowForPlayer(playerid,slot);
native TDGroupHideForPlayer(playerid,slot);

*/

enum E_TD_ENUM
{
	count,
}
new tdenum[MAX_GROUPS][E_TD_ENUM];
new TDid[MAX_GROUPS][TDperGroup];

stock CreateTDGroup({Text}:...)
{
	new slot = -1;

	for(new i=0;i<MAX_GROUPS;++i)
	{
	    if(tdenum[i][count] == -1)
	    {
	        slot=i;
	        break;
	    }
	}

	if(slot == -1)
	{
	    printf("No more emply slot's found. Increase MAX_GROUPS");
	    return -1;
	}

	new num = tdenum[slot][count] = numargs();

	if(num > TDperGroup)
	{
	    printf("Increase TDperGroup");
	    return -1;
	}
	for(new i=0;i<num;++i)
	{
	    TDid[slot][i]=getarg(i,0);
	}

	return slot;
}

stock DestroyTDGroup(slot)
{
	if(slot > MAX_GROUPS || slot<0)
	{
	    printf("Invalid Slot Passed in DestroyTDGroup");
	    return -1;
	}
    tdenum[slot][count] = -1;
    return 1;
}
stock TDGroupAddTD(slot,{Text}:...)
{
    if(slot > MAX_GROUPS || slot<0)
	{
	    printf("Invalid Slot Passed ");
	    return -1;
	}
    if(tdenum[slot][count] == -1) return -1;
	new num = numargs();
    new at = tdenum[slot][count];
    if((num+at-1) > MAX_GROUPS)
    {
        printf("Increase TDperGroup");
	    return -1;
    }
	new i,j;
    for(i = at,j=1;j<num;++i,++j) TDid[slot][i]=getarg(j,0);
    tdenum[slot][count]=tdenum[slot][count]+num-1;
	return 1;
}

stock TDGroupRemoveTD(slot,{Text}:...)
{
    if(slot > MAX_GROUPS || slot<0)
	{
	    printf("Invalid Slot Passed ");
	    return -1;
	}
    if(tdenum[slot][count] == -1) return -1;
	new num = numargs();
	new c = tdenum[slot][count];

	for(new j=1;j<num;++j)
	{
	    for(new i=0;i<c;++i)
		{
		    if(TDid[slot][i]==getarg(j,0))
		    {
		        c=c-1;
		        for(new k=i;k<c;++k) TDid[slot][k] = TDid[slot][k+1];
				tdenum[slot][count]--;
		        break;
		    }

		}
	}
	return 1;
}

stock TDGroupShowForAll(slot)
{
    if(slot > MAX_GROUPS || slot<0)
	{
	    printf("Invalid Slot Passed ");
	    return -1;
	}
    if(tdenum[slot][count] == -1) return -1;
	for(new i=0;i<tdenum[slot][count];++i)
		TextDrawShowForAll(Text:TDid[slot][i]);
	return 1;
}
stock TDGroupHideForAll(slot)
{
    if(slot > MAX_GROUPS || slot<0)
	{
	    printf("Invalid Slot Passed ");
	    return -1;
	}
    if(tdenum[slot][count] == -1) return -1;
	for(new i=0;i<tdenum[slot][count];++i)
		TextDrawHideForAll(Text:TDid[slot][i]);
	return 1;
}
stock TDGroupShowForPlayer(playerid,slot)
{
    if(slot > MAX_GROUPS || slot<0)
	{
	    printf("Invalid Slot Passed ");
	    return -1;
	}

    if(tdenum[slot][count] == -1) return -1;
    for(new i=0;i<tdenum[slot][count];++i)
		TextDrawShowForPlayer(playerid,Text:TDid[slot][i]);
	return 1;
}
stock TDGroupHideForPlayer(playerid,slot)
{
    if(slot > MAX_GROUPS || slot<0)
	{
	    printf("Invalid Slot Passed ");
	    return -1;
	}
    if(tdenum[slot][count] == -1) return -1;
    for(new i=0;i<tdenum[slot][count];++i)
		TextDrawHideForPlayer(playerid,Text:TDid[slot][i]);
	return 1;
}
