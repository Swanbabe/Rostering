/*********************************************
 * OPL 12.8.0.0 Model
 * Author: asus
 * Creation Date: 1 Apr 2019 at 5:25:43 pm
 *********************************************/

 range	Pharmacist = 1..10;
 range	Weekday = 1..122;
 range	Job = 1..24;
 
 //Decision Variables
 
 dvar boolean	y[Pharmacist][Weekday][Job];
 
 dvar boolean	C1[Weekday][Job];
 dvar boolean	C2[Weekday][Job];
 dvar boolean	C3[Weekday][Job];
 dvar boolean	C4[Weekday][Job];
 dvar boolean	C5[Weekday][Job];
 dvar boolean	C6[Weekday][Job];
 dvar boolean	C7[Weekday][Job];
 dvar boolean	C10[Weekday][Job];
 
 
 
 //Objective Function
 
dexpr int	z = sum(i in Pharmacist, j in Weekday, k in Job) y[i][j][k];

 maximize z;
 
 //Constraints
 
 subject to{
 
 //Every full-time staff memeber (EFT = 1, k in Job) requires 1 ADO per calender month
 
forall(i in 3..9)
   sum(j in 1..21) y[i][j][19] ==1;
   
forall(i in 3..9)
   sum(j in 22..41) y[i][j][19] ==1;
   
forall(i in 3..9)
   sum(j in 42..61) y[i][j][19] ==1;
   
forall(i in 3..9)
   sum(j in 62..80) y[i][j][19] ==1;
   
forall(i in 3..9)
   sum(j in 81..103) y[i][j][19] ==1;
   
forall(i in 3..9)
   sum(j in 104..122) y[i][j][19] ==1;
   

//Physical Limitation Constraint

forall(i in Pharmacist, j in Weekday)
  sum(k in 1..24) y[i][j][k] <= 1;

//Job Completion Constraint

forall(j in Weekday, k in 1..8)
  sum(i in Pharmacist) y[i][j][k] == 1;



  
//Late Shift/Leave/Time in Lieu/etc


///for i = 1 (Two part-timers, k in Job);

sum(j in 3..4) C1[j][18] ==2;

C1[28][18] ==1;

C1[35][18] ==1;

C1[71][18] ==1;

sum(j in 86..87) C1[j][18] ==2;

C1[90][18] ==1;

////Total Days Off:

sum(j in Weekday, k in Job) C1[j][k] == 8;


///for i = 2 (Two part-timers, k in Job);

sum(j in 1..2) C2[j][18] ==2;
sum(j in 1..2) y[2][j][18] ==2;

sum(j in 23..24) C2[j][18] ==2;
sum(j in 23..24) y[2][j][18] ==2;

C2[26][24] == 1;
y[2][26][24] ==1;

sum(j in 28..29) C2[j][22] ==2;
sum(j in 28..29) y[2][j][22] ==2;

C2[32][22] == 1;
y[2][32][22] == 1;

C2[39][18] == 1;
y[2][39][18] == 1;

sum(j in 42..44) C2[j][18] == 3;
sum(j in 42..44) y[2][j][18] == 3;

C2[47][18] == 1;
y[2][47][18] == 1;

////Total Days Off:

sum(j in Weekday, k in Job) C2[j][k] == 13;


///for i = 3;

sum(j in 15..17) C3[j][20] == 3;
sum(j in 15..17) y[3][j][20] == 3;

C3[22][20] == 1;
y[3][22][20] == 1;

sum(j in 99..108) C3[j][20] == 10;
sum(j in 99..108) y[3][j][20] == 10;

////Total Days Off:

sum(j in Weekday, k in Job) C3[j][k] == 14;


///for i = 4;

sum(j in 67..71) C4[j][20] == 5;
sum(j in 67..71) y[4][j][20] == 5;

////Total Days Off:

sum(j in Weekday, k in Job) C4[j][k] == 5;


///for i = 5;

sum(j in 84..88) C5[j][20] == 5;
sum(j in 84..88) y[5][j][20] == 5;

////Total Days Off:

sum(j in Weekday, k in Job) C5[j][k] == 5;


///for i = 6;

sum(j in 52..64) C6[j][18] == 13;
sum(j in 52..64) y[6][j][18] == 13;

sum(j in 72..75) C6[j][20] == 4;
sum(j in 72..75) y[6][j][20] ==4;

////Total Days Off:

sum(j in Weekday, k in Job) C6[j][k] == 17;


///for i = 7;

sum(j in 4..8) C7[j][20] == 5;
sum(j in 4..8) y[7][j][20] == 5;

////Total Days Off:

sum(j in Weekday, k in Job) C7[j][k] == 5;


///for i = 8;

sum(j in 9..13) y[8][j][20] == 5;

sum(j in 31..32) y[8][j][21] ==2;


///for i = 10;

C10[13][18] ==1;
y[10][13][18] ==1;

C10[113][22] ==1;
y[10][113][22] ==1;

C10[117][22] ==1;
y[10][117][22] ==1;

C10[118][22] ==1;
y[10][118][22] ==1;

C10[122][22] ==1;
y[10][122][22] ==1;

////Total Days Off:

sum(j in Weekday, k in Job) C10[j][k] == 5;





//Individual Rotation Constraint

///for i = 1 (Two part-timers, k in Job);

forall(j in Weekday, k in Job)
  y[1][j][1] <= 1 - C1[j][k];
  
forall(j in Weekday, k in Job)
  y[1][j][1] >= 1 - C1[j][k];

forall(j in Weekday, k in Job)
  y[1][j][18] <= C1[j][k];

forall(j in Weekday, k in Job)
  y[1][j][18] >= C1[j][k];

///for i = 2 (Two part-timers, k in Job);

forall(j in Weekday, k in Job)
  y[2][j][2] <= 1 - C2[j][k];
  
forall(j in Weekday, k in Job)
  y[2][j][2] >= 1 - C2[j][k];

forall(j in Weekday, k in Job)
  y[2][j][k] <= C2[j][k];

forall(j in Weekday, k in Job)
  y[2][j][k] >= C2[j][k];
  
  
///for i = 3;

forall(j in Weekday, k in Job)
  y[3][j][3] <= 1 - C3[j][k];
  
forall(j in Weekday, k in Job)
  y[3][j][3] >= 1 - C3[j][k];

forall(j in Weekday, k in Job)
  y[3][j][k] <= C3[j][k];

forall(j in Weekday, k in Job)
  y[3][j][k] >= C3[j][k];
  
  
///for i = 4;

forall(j in Weekday, k in Job)
  y[4][j][4] <= 1 - C4[j][k];
  
forall(j in Weekday, k in Job)
  y[4][j][4] >= 1 - C4[j][k];

forall(j in Weekday, k in Job)
  y[4][j][k] <= C4[j][k];

forall(j in Weekday, k in Job)
  y[4][j][k] >= C4[j][k];



///for i = 5;

forall(j in Weekday, k in Job)
  y[5][j][5] <= 1 - C5[j][k];
  
forall(j in Weekday, k in Job)
  y[5][j][5] >= 1 - C5[j][k];

forall(j in Weekday, k in Job)
  y[5][j][k] <= C5[j][k];

forall(j in Weekday, k in Job)
  y[5][j][k] >= C5[j][k];
  
  
///for i = 6;

forall(j in Weekday, k in Job)
  y[6][j][6] <= 1 - C6[j][k];
  
forall(j in Weekday, k in Job)
  y[6][j][6] >= 1 - C6[j][k];

forall(j in Weekday, k in Job)
  y[6][j][k] <= C6[j][k];

forall(j in Weekday, k in Job)
  y[6][j][k] >= C6[j][k];  
  

///for i = 7;

forall(j in Weekday, k in Job)
  y[7][j][7] <= 1 - C7[j][k];
  
forall(j in Weekday, k in Job)
  y[7][j][7] >= 1 - C7[j][k];

forall(j in Weekday, k in Job)
  y[7][j][k] <= C7[j][k];

forall(j in Weekday, k in Job)
  y[7][j][k] >= C7[j][k];  
  
///for i = 10;

forall(j in Weekday, k in Job)
  y[10][j][8] <= 1 - C10[j][k];
  
forall(j in Weekday, k in Job)
  y[10][j][8] >= 1 - C10[j][k];

forall(j in Weekday, k in Job)
  y[10][j][k] <= C10[j][k];

forall(j in Weekday, k in Job)
  y[10][j][k] >= C10[j][k];  
  
} 