close all
clear all

format long

R1 = 1.04921233729 * 10^3
R2 = 2.01121557182 * 10^3
R3 = 3.04491334831 * 10^3
R4 = 4.07370420497 * 10^3
R5 = 3.04829678473 * 10^3
R6 = 2.08879558009 * 10^3
R7 = 1.01335761883 * 10^3
Va = 5.22566789497 
Id = 1.04037874222 * 10^-3
Kb = 7.00318569445 * 10^-3
Kc = 8.05999483103 * 10^3

printf("\n\n%%%%%%%% MESH ANALYSIS %%%%%%%%\n\n");

Am = [0, 0, 0, 1; R1+R3+R4, -R3, -R4, 0; -R4, 0, R4+R6+R7-Kc, 0; -Kb*R3, Kb*R3-1, 0, 0]
Bm = [Id; -Va; 0; 0]
Cm = Am\Bm

printf("\nMesh currents\n");
IA = Cm(1)
IB = Cm(2)
IC = Cm(3)
ID = Cm(4)

printf("\nNodal voltages\n");
V1m = Va
V2m = V1m+R1*IA
V3m = V2m-R3*(IB-IA)
V4m = V2m+R2*IB
V5m = V3m-R5*(IB-ID)
V6m = V3m-Kc*IC
V7m = -R6*IC

printf("\nResistor currents\n");
I1m = -IA
I2m = -IB
I3m = IB-IA
I4m = IC-IA
I5m = IB-ID
I6m = IC
I7m = IC

printf("\nNamed currents and tensions\n");
Icm = IC
Vbm = R3*(IB-IA)
Vcm = Kc*Icm
Ibm = Kb*Vbm

printf("\n\n%%%%%%%% NODAL ANALYSIS %%%%%%%%\n\n");

An = [1, 0, 0, 0, 0, 0, 0;
     0, 0, 1, 0, 0, -1, Kc/R6;
     0, 0, 0, 0, 0, -1/R7, 1/R7+1/R6;
     -1/R1, 1/R1, 1/R4, 0, 0, 0, 1/R6;
     0, 1/R3, -1/R3-1/R4-1/R5, 0, 1/R5, -1/R7, 1/R7;
     0, Kb, -Kb-1/R5, 0, 1/R5, 0, 0;
     1/R1, -1/R1-1/R3-1/R2, 1/R3, 1/R2, 0, 0, 0]

Bn = [Va; 0; 0; 0; Id; Id; 0]
Cn = An\Bn

printf("\nNodal voltages\n");
V1n = Cn(1)
V2n = Cn(2)
V3n = Cn(3)
V4n = Cn(4)
V5n = Cn(5)
V6n = Cn(6)
V7n = Cn(7)

printf("\nResistor currents\n");
I1n = (V1n-V2n)/R1
I2n = (V2n-V4n)/R2
I3n = (V2n-V3n)/R3
I4n = V3n/R4
I5n = (V3n-V5n)/R5
I6n = -V7n/R6
I7n = (V7n-V6n)/R7

printf("\nNamed currents and tensions\n");
Vbn = V2n-V3n
Ibn = Kb*Vbn
Icn = -V7n/R6
Vcn = Kc*Icn

printf("\n\n%%%%%%%%%%%%\n\n");

diary "Mesh_tab.tex"
diary on
printf("$I_b$ & %f\n", Ibm);
printf("$I_d$ & %f\n", Id);
printf("$I_1$ & %f\n", I1m);
printf("$I_2$ & %f\n", I2m);
printf("$I_3$ & %f\n", I3m);
printf("$I_4$ & %f\n", I4m);
printf("$I_5$ & %f\n", I5m);
printf("$I_6$ & %f\n", I6m);
printf("$I_7$ & %f\n", I7m);
printf("$V_1$ & %f\n", V1m);
printf("$V_2$ & %f\n", V2m);
printf("$V_3$ & %f\n", V3m);
printf("$V_4$ & %f\n", V4m);
printf("$V_5$ & %f\n", V5m);
printf("$V_6$ & %f\n", V6m);
printf("$V_7$ & %f\n", V7m);
diary off


diary "Nodal_tab.tex"
diary on
printf("$I_b$ & %f\n", Ibn);
printf("$I_d$ & %f\n", Id);
printf("$I_1$ & %f\n", I1n);
printf("$I_2$ & %f\n", I2n);
printf("$I_3$ & %f\n", I3n);
printf("$I_4$ & %f\n", I4n);
printf("$I_5$ & %f\n", I5n);
printf("$I_6$ & %f\n", I6n);
printf("$I_7$ & %f\n", I7n);
printf("$V_1$ & %f\n", V1n);
printf("$V_2$ & %f\n", V2n);
printf("$V_3$ & %f\n", V3n);
printf("$V_4$ & %f\n", V4n);
printf("$V_5$ & %f\n", V5n);
printf("$V_6$ & %f\n", V6n);
printf("$V_7$ & %f\n", V7n);
diary off
