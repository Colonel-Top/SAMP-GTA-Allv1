#pragma config(Sensor, S1,     RLight,         sensorLightActive)
#pragma config(Sensor, S2,     CLight,         sensorLightActive)
#pragma config(Sensor, S3,     LLight,         sensorLightActive)
#pragma config(Motor,  motorA,          GMotor,        tmotorNXT, openLoop, encoder)
#pragma config(Motor,  motorB,          RMotor,        tmotorNXT, openLoop, encoder)
#pragma config(Motor,  motorC,          LMotor,        tmotorNXT, openLoop, encoder)

void Track2Line()
{
	int a;
	a=39;
		while(1)//Loop Forever
	{
		if(SensorValue(RLight)>a && SensorValue(LLight)>a)//if Right Light Sensor and Left Light Sensor are WHITE
		{
			//Robot Go Straight
			motor[RMotor]=60;
			motor[LMotor]=60;
		}
		else if(SensorValue(RLight)>a && SensorValue(LLight)<a)//if Right Light Sensor is WHITE and Left Light Sensor is BLACK
		{
			//Robot Spin Left
			motor[RMotor]=60;
			motor[LMotor]=-60;
		}
		else if(SensorValue(RLight)<a && SensorValue(LLight)>a)//if Right Light Sensor is BLACK and Left Light Sensor is WHITE
		{
			//Robot Spin Right
			motor[RMotor]=-60;
			motor[LMotor]=60;
		}
		else if(SensorValue(RLight)<a && SensorValue(LLight)<a)//if Right Light Sensor and Left Light Sensor are BLACK
		{
			//Robot Stop and End of Loop
			motor[RMotor]=0;
			motor[LMotor]=0;
			break;
		}
	}
}
void gototime(int t)
{
	motor[RMotor]=30;
	motor[LMotor]=30;
  wait1Msec(t);
}

void goback(int t)
{
	motor[RMotor]=-30;
	motor[LMotor]=-30;
  wait1Msec(t);

}
void Mstop(int b)
{
  motor[RMotor]=0;
  motor[LMotor]=0;
  wait1Msec(b);
}
void TurnLeft(int l)
{
	motor[RMotor]=90;
	motor[LMotor]=-50;
	wait1Msec(l);
}
void TurnRight(int r)
{
	motor[RMotor]=-50;
	motor[LMotor]=90;
	wait1Msec(r);
}
void LeftTrack()
{
	while(SensorValue[RLight]>39)
	 {
	 	if(SensorValue[LLight]>39)
	   {
	    	motor[RMotor]=0;
	      motor[LMotor]=60;
	   }
	  else if(SensorValue[LLight]<39)
	   {
	    	motor[RMotor]=60;
	      motor[LMotor]=0;
  	 }
   }
  if(SensorValue[LLight]<39)
   {
     Mstop(1);
   }
}
void RightTrack()
{
	while(SensorValue[RLight]>39)
	 {
	 	if(SensorValue[LLight]>39)
	   {
	    	motor[RMotor]=0;
	      motor[LMotor]=60;
	   }
	  else if(SensorValue[LLight]<39)
	   {
	    	motor[RMotor]=60;
	      motor[LMotor]=0;
  	  }
   }
  if(SensorValue[RLight]<39)
    {
      Mstop(1);
    }
}

void Drop()
{
motor[GMotor]=20;
wait1Msec(700);
motor[GMotor]=0;
wait1Msec(1000);

gototime(1500);
Mstop(400);
motor[GMotor]=40;
wait1Msec(800);
}

void wait4top(int w)
{
  for(;w>0;w--)
  {
    goback(1500);
    Track2Line();
  }
  goback(1500);
  PlaySound(soundUpwardTones);
  Track2Line();
  PlaySound(soundUpwardTones);
  goback(1500);
  PlaySound(soundUpwardTones);
  Track2Line();
  PlaySound(soundUpwardTones);
  goback(1500);
  Track2Line();
}

void whitecan()
{
    if(SensorValue(CLight)>=3)//detected white can
	 {
		motor(GMotor)=-50;
		wait1Msec(2600);
    goback(3900);
    Mstop(1);
    TurnLeft(600);
    Track2Line();
    Mstop(500);
    PlaySound(soundBeepBeep);
    TurnLeft(700);
	  wait1Msec(100);
   	LeftTrack();
    PlaySound(soundBeepBeep);
    Mstop(5);
    PlaySound(soundBeepBeep);
    motor[LMotor]=10;
    motor[RMotor]=50;
    wait1Msec(700);
    Mstop(1);

    Track2Line();
    gototime(600);
    Mstop(1);
    Drop();
    goback(4100);
    PlaySound(soundBeepBeep);
    TurnLeft(650);
    LeftTrack();
    Track2Line();
    TurnLeft(200);
    Track2Line();
    TurnLeft(600);
   }
}

void blackcan()
{
    if(SensorValue(CLight)<30)//detected black can
	 {
		motor(GMotor)=-50;
		wait1Msec(2600);
    goback(3900);
    Mstop(1);
    TurnRight(600);
    Track2Line();
    Mstop(500);
    PlaySound(soundBeepBeep);
    TurnRight(700);
	  wait1Msec(100);
   	RightTrack();
    PlaySound(soundBeepBeep);
    Mstop(5);
    PlaySound(soundBeepBeep);
    motor[LMotor]=50;
    motor[RMotor]=10;
    wait1Msec(700);
    Mstop(1);

    Track2Line();
    gototime(600);
    Mstop(1);
    Drop();
    goback(4100);
    PlaySound(soundBeepBeep);
    TurnRight(650);
    RightTrack();
    Track2Line();
    TurnRight(200);
    Track2Line();
    TurnRight(600);
   }
}


task main()
{
	PlaySound(soundBlip);
  gototime(1754);
  Mstop(1);
	Track2Line();
	Mstop(1);
	Track2Line();
	gototime(1000);
	Mstop(1);
  Track2Line();
  gototime(2200);
  Mstop(1);

  wait4top(10);

  gototime(1500);
  Mstop(2000);
  PlaySound(soundBeepBeep);

  whitecan();
  blackcan();

  Track2Line();
  gototime(2200);
  Mstop(1)

  wait4top(w);

  gototime(1500);
  Mstop(2000);
  PlaySound(soundBeepBeep);

  whitecan();
  blackcan();

  Track2Line();
  gototime(2200);
  Mstop(1)

  wait4top(w);

  gototime(1500);
  Mstop(2000);
  PlaySound(soundBeepBeep);

  whitecan();
  blackcan();

  Track2Line();
  gototime(2200);
  Mstop(1)

  wait4top(w);

  gototime(1500);
  Mstop(2000);
  PlaySound(soundBeepBeep);

  whitecan();
  blackcan();




}
