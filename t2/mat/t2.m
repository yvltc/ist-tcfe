close all
clear all

format long

fp = fopen("data.txt", "r")

Data = fscanf(fp, "%*s = %f")

fclose(fp)

R1 = Data(1)
R2 = Data(2)
R3 = Data(3)
R4 = Data(4)
R5 = Data(5)
R6 = Data(6)
R7 = Data(7)
Vs = Data(8)
C = Data(9)
Kb = Data(10)
Kd = Data(11)

fp = fopen("data1_ng.txt", "w")

fprintf(fp, "R1 1 2 %.11fk\n", R1)
fprintf(fp, "R2 2 3 %.11fk\n", R2)
fprintf(fp, "R3 2 5 %.11fk\n", R3)
fprintf(fp, "R4 5 0 %.11fk\n", R4)
fprintf(fp, "R5 5 6 %.11fk\n", R5)
fprintf(fp, "R6 0 4 %.11fk\n", R6)
fprintf(fp, "R7 7 8 %.11fk\n", R7)
fprintf(fp, "Vs 1 0 DC %.11f\n", Vs)
fprintf(fp, "C 6 8 %.11fu\n", C)
fprintf(fp, "Gb 6 3 (2,5) %.11fm\n", Kb)
fprintf(fp, "Hd 6 8 Vaux %.11fk\n", Kd)
fprintf(fp, "Vaux 4 7 DC 0")

fclose(fp)
