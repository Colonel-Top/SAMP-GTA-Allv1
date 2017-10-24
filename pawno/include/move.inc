#define MAX_OBJECTS 150

forward CreateObjectGroup(float:x, float:y, float:z);
forward AddObjectToObjectGroup(object_groupid, objectid);
forward init_GroupedObjects();
forward CreateGroupObject(modelid, groupid, float:aX, float:aY, float:aZ, float:arX, float:arY, float:arZ);
forward MoveObjectGroup(groupid, float:newX, float:newY, float:newZ, float:speed);

enum o_i_enum
{
	gid,
	float:X,
	float:Y,
	float:Z,
	float:rX,
	float:rY,
	float:rZ
}

enum o_g_enum
{
	float:X,
	float:Y,
	float:Z
}

new object_info	[MAX_OBJECTS]	[o_i_enum];
new ogroup_info	[MAX_OBJECTS]	[o_g_enum];
new obj_groups = 0;

public init_GroupedObjects()
{
	for(new i = 0; i < MAX_OBJECTS; i++)
	{
		object_info[i][gid] = 0;
	}
}

public CreateObjectGroup(float:x, float:y, float:z)
{
	if(obj_groups >= MAX_OBJECTS) return -1;
	new obj_return = obj_groups;
	ogroup_info[obj_groups][X] = x;
	ogroup_info[obj_groups][Y] = y;
	ogroup_info[obj_groups][Z] = z;
	obj_groups++;
	return obj_return;
}

public AddObjectToObjectGroup(object_groupid, objectid)
{
	object_info[objectid][gid] = object_groupid;
}

public CreateGroupObject(modelid, groupid, float:aX, float:aY, float:aZ, float:arX, float:arY, float:arZ)
{
	new cur_objects = CreateObject(modelid, float:X, float:Y, float:Z, float:rX, float:rY, float:rZ);
	object_info[cur_objects][X] = aX; 	object_info[cur_objects][Y] = aY; 	object_info[cur_objects][Z] = aZ;
	object_info[cur_objects][rX] = arX; 	object_info[cur_objects][rY] = arY; 	object_info[cur_objects][rZ] = arZ;
	object_info[cur_objects][gid] = groupid;
}

public MoveObjectGroup(groupid, float:newX, float:newY, float:newZ, float:speed)
{
	ogroup_info[groupid][X] = newX;
	ogroup_info[groupid][Y] = newY;
	ogroup_info[groupid][Z] = newZ;
	for(new i = 0; i < MAX_OBJECTS; i++)
	{
		if(object_info[i][gid] == groupid)
		{
			new float:x[2],
				float:y[2],
				float:z[2];

			GetObjectPos(i, x[0], y[0], z[0]);
			x[1] = ogroup_info[groupid][X]-x[0]+newX;
			y[1] = ogroup_info[groupid][Y]-y[0]+newY;
			z[1] = ogroup_info[groupid][Z]-z[0]+newZ;

			MoveObject(objectid, x[1], y[1], z[1], speed);
		}
	}
}
