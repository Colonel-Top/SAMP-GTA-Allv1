#include <a_samp>
#include <sscanf2>


#define MAX_OBJECTS_TO_REMOVE   500


enum obInfo
{
        Model,
        Float:X,
        Float:Y,
        Float:Z,
        Float:Radius,
}
new ObjectInfo[MAX_OBJECTS_TO_REMOVE][obInfo];



forward ConvertF(const file[]);
public ConvertF(const file[])
{
    new File:openfile = fopen(file,io_read);
    if(!openfile) return printf("File %s was not found. Please make sure you have placed it on your ScriptFiles folder.", file);
    new File:newfile = fopen("RemoveBuilding.pwn",io_write);
    fwrite(newfile, "public OnPlayerConnect(playerid)\r\n{\r\n");
    new string[350], lods, normal, objects, object, m;
    while(fread(openfile, string))
    {
        if(object >= sizeof(ObjectInfo)) break;
        if(!sscanf(string, "'lodModel=\"'p<\">d", m))
        {
            if(m != 0)
            {
		        if(!sscanf(string, "'radius=\"'p<\">f'lodModel=\"'p<\">d'posX=\"'p<\">f'posY=\"'p<\">f'posZ=\"'p<\">f",ObjectInfo[object][Radius], ObjectInfo[object][Model],ObjectInfo[object][X],ObjectInfo[object][Y],ObjectInfo[object][Z]))
		        {
		            format(string,sizeof(string),"\tRemoveBuildingForPlayer(playerid, %d, %.4f, %.4f, %.4f, %.4f);\r\n",ObjectInfo[object][Model],ObjectInfo[object][X],ObjectInfo[object][Y],ObjectInfo[object][Z], ObjectInfo[object][Radius]);
		            fwrite(newfile,string);
		            lods++;
		            objects++;
		        }
			}
	        else
	        {
		        if(!sscanf(string, "'radius=\"'p<\">f'model=\"'p<\">d'posX=\"'p<\">f'posY=\"'p<\">f'posZ=\"'p<\">f",ObjectInfo[object][Radius], ObjectInfo[object][Model],ObjectInfo[object][X],ObjectInfo[object][Y],ObjectInfo[object][Z]))
		        {
		            format(string,sizeof(string),"\tRemoveBuildingForPlayer(playerid, %d, %.4f, %.4f, %.4f, %.4f);\r\n",ObjectInfo[object][Model],ObjectInfo[object][X],ObjectInfo[object][Y],ObjectInfo[object][Z], ObjectInfo[object][Radius]);
		            fwrite(newfile,string);
		            normal++;
		            objects++;
		        }
			}
		}
    }
    fwrite(newfile, "\treturn 1;\r\n}");
    fclose(openfile);
    fclose(newfile);
    printf("Objects Converted: %d ", objects);
    printf("Lod models: %d | Models: %d", lods, normal);
    print("Remove Building code has been exported to RemoveBuilding.pwn");
    return object;
}
