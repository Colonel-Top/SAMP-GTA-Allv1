#include <stdio.h>

	int day,cases,choice;
	int count[8];
	int recieve;
	int t1,t2,t3,t4,t5,t6,t7,t8;

int printout()
{
	printf("Task Activities of the days be at the center");
	printf("%d",day);
	printf("========================");
	printf("1.Wake up");
	printf("2.Brushing teeth");
	printf("3.Have Breakfast");
	printf("4.Lunch");
	printf("5.Dinner");
	printf("6.Pana times");
	printf("7.Talking");
	printf("8.Walking");
	return 1;
}
int main(void)
{
    t1=0;
    t2=0;
    t3=0;
    t4=0;
    t5=0;
    t6=0;
    t7=0;
    t8=0;
	day =3;
	printout();
	scanf("Select Your activities %d",&cases);
	if (cases == 1)
 	{
	    if(t1 == 1)
		{
			printf("Sorry you can't Edit until Next day");
			return printout();
		}
		else
		{
			printf("Wakeup \n Can you did it ?\n");
			printf("Select one \n 1.Always \n 2.Usually \n 3.Sometimes \n 4.Rarely \n 5.Never");
			scanf("%d",&recieve);
			if(recieve > 5 && recieve < 0)			return    printf("Invalid Input please re-enter");
			t1=1;
			count[1]= recieve;
			return printout();
		}
	}
	else if (cases == 2)
 	{
	    if(t2 == 1)
		{
			printf("Sorry you can't Edit until Next day");
			return printout();
		}
		else
		{
			printf("Brushing Teeth \n Can you did it ?\n");
			printf("Select one \n 1.Always \n 2.Usually \n 3.Sometimes \n 4.Rarely \n 5.Never");
			scanf("%d",&recieve);
			if(recieve > 5 && recieve < 0)			return    printf("Invalid Input please re-enter");
			t2=1;
			count[2]= recieve;
			return printout();
		}
	}
	else if (cases == 3)
 	{
	    if(t3 == 1)
		{
			printf("Sorry you can't Edit until Next day");
			return printout();
		}
		else
		{
			printf("Have Breakfast \n Can you did it ?\n");
			printf("Select one \n 1.Always \n 3.Usually \n 3.Sometimes \n 4.Rarely \n 5.Never");
			scanf("%d",&recieve);
			if(recieve > 5 && recieve < 0)			return    printf("Invalid Input please re-enter");
			t3=1;
			count[3]= recieve;
			return printout();
		}
	}
	else if (cases == 4)
 	{
	    if(t4 == 1)
		{
			printf("Sorry you can't Edit until Next day");
			return printout();
		}
		else
		{
			printf("Lunch Moment \n Can you did it ?\n");
			printf("Select one \n 1.Always \n 4.Usually \n 4.Sometimes \n 4.Rarely \n 5.Never");
			scanf("%d",&recieve);
			if(recieve > 5 && recieve < 0)			return    printf("Invalid Input please re-enter");
			t4=1;
			count[4]= recieve;
			return printout();
		}
	}
	else if (cases == 5)
 	{
	    if(t5 == 1)
		{
			printf("Sorry you can't Edit until Next day");
			return printout();
		}
		else
		{
			printf("Dinner Moment \n Can you did it ?\n");
			printf("Select one \n 1.Always \n 4.Usually \n 4.Sometimes \n 4.Rarely \n 5.Never");
			scanf("%d",&recieve);
			if(recieve > 5 && recieve < 0)			return    printf("Invalid Input please re-enter");
			t5=1;
			count[5]= recieve;
			return printout();
		}
	}
	else if (cases == 6)
 	{
	    if(t6 == 1)
		{
			printf("Sorry you can't Edit until Next day");
			return printout();
		}
		else
		{
			printf("Pana Moment \n Can you did it ?\n");
			printf("Select one \n 1.Always \n 4.Usually \n 4.Sometimes \n 4.Rarely \n 5.Never");
			scanf("%d",&recieve);
			if(recieve > 5 && recieve < 0)			return    printf("Invalid Input please re-enter");
			t6=1;
			count[6]= recieve;
			return printout();
		}
	}
	else if (cases == 7)
 	{
	    if(t5 == 7)
		{
			printf("Sorry you can't Edit until Next day");
			return printout();
		}
		else
		{
			printf("Talking Moment \n Can you did it ?\n");
			printf("Select one \n 1.Always \n 4.Usually \n 4.Sometimes \n 4.Rarely \n 5.Never");
			scanf("%d",&recieve);
			if(recieve > 5 && recieve < 0)			return    printf("Invalid Input please re-enter");
			t7=1;
			count[7]= recieve;
			return printout();
		}
	}
	else if (cases == 8)
 	{
	    if(t8 == 8)
		{
			printf("Sorry you can't Edit until Next day");
			return printout();
		}
		else
		{
			printf("Talking Moment \n Can you did it ?\n");
			printf("Select one \n 1.Always \n 4.Usually \n 4.Sometimes \n 4.Rarely \n 5.Never");
			scanf("%d",&recieve);
			if(recieve > 5 && recieve < 0)			return    printf("Invalid Input please re-enter");
			t8=1;
			count[8]= recieve;
			return printout();
		}
	}


		




	return 0;
}

