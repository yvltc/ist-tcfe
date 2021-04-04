pkg load symbolic

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

diary "data1_ng.txt"
diary on
printf("R1 1 2 %.11fk\n", Data(1))
printf("R2 2 3 %.11fk\n", Data(2))
printf("R3 2 5 %.11fk\n", Data(3))
printf("R4 5 0 %.11fk\n", Data(4))
printf("R5 5 6 %.11fk\n", Data(5))
printf("R6 0 4 %.11fk\n", Data(6))
printf("R7 7 8 %.11fk\n", Data(7))
printf("Vs 1 0 DC %.11f\n", Data(8))
printf("C 6 8 %.11fu\n", Data(9))
printf("Gb 6 3 (2,5) %.11fm\n", Data(10))
printf("Hd 5 8 Vaux %.11fk\n", Data(11))
printf("Vaux 4 7 DC 0")
diary off

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

diary "Nodal1_tab.tex"
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

V1_2 = D(1);
V2_2 = D(2);
V3_2 = D(3);
V5_2 = D(4);
V6_2 = D(5);
V7_2 = D(6);
V8_2 = D(7);

I1_2 = (V1_1 - V2_1)/R1;
I2_2 = (V2_1 - V3_1)/R2;
I3_2 = (V2_1 - V5_1)/R3;
I4_2 = V5_1/R4;
I5_2 = (V5_1 - V6_1)/R5;
I6_2 = -V7_1/R6;
I7_2 = (V7_1 - V8_1)/R7;

Ib_2 = Kd*(V2_2 - V5_2);

diary "Nodal2_tab.tex"
diary on
printf("$I_b$ & %e\n", Ib_2);
printf("$I_c$ & %e\n", Ix);
printf("$I_1$ & %e\n", I1_2);
printf("$I_2$ & %e\n", I2_2);
printf("$I_3$ & %e\n", I3_2);
printf("$I_4$ & %e\n", I4_2);
printf("$I_5$ & %e\n", I5_2);
printf("$I_6$ & %e\n", I6_2);
printf("$I_7$ & %e\n", I7_2);
printf("$V_1$ & %f\n", V1_2);
printf("$V_2$ & %f\n", V2_2);
printf("$V_3$ & %f\n", V3_2);
printf("$V_5$ & %f\n", V5_2);
printf("$V_6$ & %f\n", V6_2);
printf("$V_7$ & %f\n", V7_2);
printf("$V_8$ & %f\n", V8_2);
printf("$R_{eq}$ & %f\n", Req);
printf("$\\tau$ & %f\n", tau);
diary off

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

Vx = V6_1 - V8_1

v6n = figure();
x = 0:0.1:20;
plot(x, Vx * e.^(-x*10^(-3)/tau));
xlabel ("t [ms]");
ylabel ("v6n(t) [V]");
title ("Natural solution");

print(v6n, "natural.eps", "-depsc");

diary "data4_ng.txt"
diary on
printf("R1 1 2 %.11fk\n", Data(1));
printf("R2 2 3 %.11fk\n", Data(2));
printf("R3 2 5 %.11fk\n", Data(3));
printf("R4 5 0 %.11fk\n", Data(4));
printf("R5 5 6 %.11fk\n", Data(5));
printf("R6 0 4 %.11fk\n", Data(6));
printf("R7 7 8 %.11fk\n", Data(7));
printf("C 6 8 %.11fu\n", Data(9));
printf("Vs 1 0 DC 0 AC 1 -90 SIN(0 1 1k)\n", Data(8));
printf("Vaux 4 7 DC 0\n");
printf("Hd 5 8 Vaux %.11fk\n", Data(11));
printf("Gb 6 3 (2,5) %.11fm\n", Data(10));
printf(".ic v(6) = %.11f v(8) = 0", V6_1 - V8_1);
diary off

%syms vs(t,f)
%vs(t,f) = e^(2*pi*f*J*t)

Zc = 1/(J*2*pi*10^3*C)

A = [-1/R1, 1/R1+1/R2+1/R3, -1/R2, -1/R3, 0, 0, 0;
     
      0, Kb+1/R2, -1/R2, -Kb, 0, 0, 0;
      
      1/R1, -1/R1, 0, -1/R4, 0, -1/R6, 0;
      
      0, Kb, 0, -(1/R5+Kb), 1/R5+1/Zc, 0, -1/Zc;
      
      0, 0, 0, 0, 0, 1/R6+1/R7, -1/R7;
      
      1, 0, 0, 0, 0, 0, 0;
      
      0, 0, 0, 1, 0, Kd/R6, -1]

B = [0; 0; 0; 0; 0; 1; 0]

D = A\B

V1_4 = abs(D(1));
V2_4 = abs(D(2));
V3_4 = abs(D(3));
V5_4 = abs(D(4));
V6_4 = abs(D(5));
V7_4 = abs(D(6));
V8_4 = abs(D(7));

diary "Nodal4_tab.tex"
diary on
printf("$V_1$ & %f\n", V1_4);
printf("$V_2$ & %f\n", V2_4);
printf("$V_3$ & %f\n", V3_4);
printf("$V_5$ & %f\n", V5_4);
printf("$V_6$ & %f\n", V6_4);
printf("$V_7$ & %f\n", V7_4);
printf("$V_8$ & %f\n", V8_4);
diary off