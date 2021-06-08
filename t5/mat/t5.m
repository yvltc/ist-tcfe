close all
clear all

%C1 = 220*10^(-9);
%C2 = 220*10^(-9);
%R1 = 1*10^3; %vamos ter de ver
%R2 = 1/(1/(1*10^3) + (1/(1*10^3))); %vamos ter de ver
%R3 = (100+100+100+10+1/(1/10+1/10))*10^3; %vamos ter de ver
%R4 = 1/(1/(10*10^3) + (1/(10*10^3)));

R1 = 1*10^3;
R2 = 1*10^3;
R3 = 3*100*10^3 + 15*10^3;
R4 = 1*10^3;
C1 = 220*220/(220+220)*10^(-9);
C2 = 220*10^(-9);

f = logspace(1, 8, 700);

for a = 1:1:700
  
  w = 2*pi*f(a);
  T = R1*C1*j*w/(1+j*w*R1*C1)*(1+R3/R4)/(1+j*w*R2*C2);

  G_dB(a) = 20*log10(abs(T));
  phase(a) = angle(T)*180/pi;

endfor

wL = 1/(R1*C1);
wH = 1/(R2*C2);
w0 = (wL*wH)^0.5;

fL = wL/(2*pi);
fH = wH/(2*pi);
f0 = w0/(2*pi);

Zin = abs((1+j*2*pi*1000*R1*C1)/(j*2*pi*1000*C1));
Zout = abs(R2/(1+j*2*pi*1000*R2*C2))
%Zout = abs(R2+1/(j*2*pi*1000*C2));
G_1000 = 20*log10(abs(R1*C1*j*2*pi*1000/(1+j*2*pi*1000*R1*C1)*(1+R3/R4)/(1+j*2*pi*1000*R2*C2)));

hf1 = figure (1);
semilogx(f, G_dB);
xlabel ("f [Hz]");
ylabel ("Gain [dB]");
print(hf1, "gain_dB.eps", "-depsc");

hf2 = figure (2);
semilogx(f, phase);
xlabel ("f [Hz]");
ylabel ("phase [deg]");
print(hf2, "phase_theo.eps", "-depsc");


cost = 1.3323*10^4 + 0.660 + 3*(100+1+10);
merit = 1/((10^(-6)+abs(R1*C1*j*2*pi*1000/(1+j*2*pi*1000*R1*C1)*(1+R3/R4)/(1+j*2*pi*1000*R2*C2) - 100)+abs(f0 - 1000))*cost);

diary "components_tab.tex"
diary on
printf("$R_1$ & %e\n", R1);
printf("$R_2$ & %e\n", R2);
printf("$R_3$ & %e\n", R3);
printf("$R_4$ & %e\n", R4);
printf("$C_1$ & %e\n", C1);
printf("$C_2$ & %e\n", C2);
diary off

diary "results_tab.tex"
diary on
printf("$f_L$ & %f\n", fH);
printf("$f_H$ & %f\n", fL);
printf("$f_0$ & %f\n", f0);
printf("$G_{1kHz}$ & %f\n", G_1000);
diary off

diary "impedances_tab.tex"
diary on
printf("$Z_{in}$ & %f\n", Zin);
printf("$Z_{out}$ & %f\n", Zout);
diary off
