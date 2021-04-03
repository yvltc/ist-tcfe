close all
clear all

format long

fp = fopen("data.txt", "r")

Data = fscanf(fp, "%*s = %f")

fclose(fp)

R1 = Data(1) * 10^3;
R2 = Data(2) * 10^3;
R3 = Data(3) * 10^3;
R4 = Data(4) * 10^3;
R5 = Data(5) * 10^3;
R6 = Data(6) * 10^3;
R7 = Data(7) * 10^3;
Vs = Data(8);
C = Data(9) * 10^(-6);
Kb = Data(10) * 10^(-3);
Kd = Data(11) * 10^3;

fp = fopen("data1_ng.txt", "w")

fprintf(fp, "R1 1 2 %.11fk\n", Data(1))
fprintf(fp, "R2 2 3 %.11fk\n", Data(2))
fprintf(fp, "R3 2 5 %.11fk\n", Data(3))
fprintf(fp, "R4 5 0 %.11fk\n", Data(4))
fprintf(fp, "R5 5 6 %.11fk\n", Data(5))
fprintf(fp, "R6 0 4 %.11fk\n", Data(6))
fprintf(fp, "R7 7 8 %.11fk\n", Data(7))
fprintf(fp, "Vs 1 0 DC %.11f\n", Data(8))
fprintf(fp, "C 6 8 %.11fu\n", Data(9))
fprintf(fp, "Gb 6 3 (2,5) %.11fm\n", Data(10))
fprintf(fp, "Hd 5 8 Vaux %.11fk\n", Data(11))
fprintf(fp, "Vaux 4 7 DC 0")

fclose(fp)

A = [-1/R1, 1/R1 + 1/R2 + 1/R3, -1/R2, -1/R3, 0, 0, 0;
     
      0, Kb + 1/R2, -1/R2, -Kb, 0, 0, 0;
     
      0, -1/R3, 0, 1/R3 + 1/R4 + 1/R5, -1/R5, -1/R7, 1/R7;
     
      0, Kb, 0, -(1/R5 + Kb), 1/R5, 0, 0;
      
      0, 0, 0, 0, 0, 1/R6 + 1/R7, -1/R7;
      
      1, 0, 0, 0, 0, 0, 0;
      
      0, 0, 0, 1, 0, Kd/R6, -1]

B = [0; 0; 0; 0; 0; Vs; 0]
D = A\B

V1_1 = D(1);
V2_1 = D(2);
V3_1 = D(3);
V5_1 = D(4);
V6_1 = D(5);
V7_1 = D(6);
V8_1 = D(7);

I1_1 = (V1_1 - V2_1)/R1;
I2_1 = (V2_1 - V3_1)/R2;
I3_1 = (V2_1 - V5_1)/R3;
I4_1 = V5_1/R4;
I5_1 = (V5_1 - V6_1)/R5;
I6_1 = -V7_1/R6;
I7_1 = (V7_1 - V8_1)/R7;

Ib_1 = Kb*(V2_1 - V5_1);

diary "Nodal_tab.tex"
diary on
printf("$I_b$ & %e\n", Ib_1);
printf("$I_c$ & 0\n");
printf("$I_1$ & %e\n", I1_1);
printf("$I_2$ & %e\n", I2_1);
printf("$I_3$ & %e\n", I3_1);
printf("$I_4$ & %e\n", I4_1);
printf("$I_5$ & %e\n", I5_1);
printf("$I_6$ & %e\n", I6_1);
printf("$I_7$ & %e\n", I7_1);
printf("$V_1$ & %f\n", V1_1);
printf("$V_2$ & %f\n", V2_1);
printf("$V_3$ & %f\n", V3_1);
printf("$V_5$ & %f\n", V5_1);
printf("$V_6$ & %f\n", V6_1);
printf("$V_7$ & %f\n", V7_1);
printf("$V_8$ & %f\n", V8_1);
diary off

diary "data2_ng.txt"
diary on
printf("R1 1 2 %.11fk\n", Data(1));
printf("R2 2 3 %.11fk\n", Data(2));
printf("R3 2 5 %.11fk\n", Data(3));
printf("R4 5 0 %.11fk\n", Data(4));
printf("R5 5 6 %.11fk\n", Data(5));
printf("R6 0 4 %.11fk\n", Data(6));
printf("R7 7 8 %.11fk\n", Data(7));
printf("Vx 6 8 DC %.6f\n", V6_1-V8_1);
printf("Vs 1 0 DC 0\n");
printf("Vaux 4 7 DC 0\n");
printf("Hd 5 8 Vaux %.11fk\n", Data(11));
printf("Gb 6 3 (2,5) %.11fm\n", Data(10));
diary off

%A = [-1/R1, 1/R1 + 1/R2 + 1/R3, -1/R2, -1/R3, 0, 0, 0, 0;

%    0, Kb + 1/R2, -1/R2, -Kb, 0, 0, 0, 0;
    
 %   1/R1, -1/R1, 0, -1/R4, 0, -1/R6, 0, 0;
    
  %  0, -1/R3, 0, 1/R3 + 1/R4 + 1/R5, -1/R5, -1/R7, 1/R7, 1;
    
   % 0, Kb, 0, -(Kb + 1/R5), 1/R5, 0, 0, -1;
    
    %0, 0, 0, 0, 0, 1/R6 + 1/R7, -1/R7, 0;
    
    %0, 0, 0, 0, 1, 0, -1, 0;
    
    %0, 0, 0, 1, 0, Kd/R6, -1, 0]
    
A = [-1/R1, 1/R1 + 1/R2 + 1/R3, -1/R2, -1/R3, 0, 0, 0;
     
      0, Kb + 1/R2, -1/R2, -Kb, 0, 0, 0;
     
      1/R1, -1/R1, 0, -1/R4, 0, -1/R6, 0;
     
      0, 0, 0, 0, 1, 0, -1;
      
      0, 0, 0, 0, 0, 1/R6 + 1/R7, -1/R7;
      
      1, 0, 0, 0, 0, 0, 0;
      
      0, 0, 0, 1, 0, Kd/R6, -1]
    
B = [ 0; 0; 0; V6_1 - V8_1; 0; 0; 0]

D = A\B

Ix = Kb*(D(2)-D(4)) + (D(5)-D(4))/R5;

Req = (V6_1 - V8_1)/Ix

tau = Req*C

diary "data3_ng.txt"
diary on
printf("R1 1 2 %.11fk\n", Data(1));
printf("R2 2 3 %.11fk\n", Data(2));
printf("R3 2 5 %.11fk\n", Data(3));
printf("R4 5 0 %.11fk\n", Data(4));
printf("R5 5 6 %.11fk\n", Data(5));
printf("R6 0 4 %.11fk\n", Data(6));
printf("R7 7 8 %.11fk\n", Data(7));
printf("C 6 8 %.11fu\n", Data(9));
printf("Vs 1 0 DC 0\n");
printf("Vaux 4 7 DC 0\n");
printf("Hd 5 8 Vaux %.11fk\n", Data(11));
printf("Gb 6 3 (2,5) %.11fm\n", Data(10));
printf(".ic v(6) = %.11f v(8) = 0", V6_1 - V8_1);
diary off