close all
clear all

C1 = 220*10^(-9);
C2 = 220*10^(-9);
R1 = 1*10^3; %vamos ter de ver
R2 = 1/(1/(1*10^3) + (1/(1*10^3))); %vamos ter de ver
R3 = (100+100+100+10)*10^3; %vamos ter de ver
R4 = 1/(1/(10*10^3) + (1/(10*10^3)));

f = logspace(1, 8, 700);

for a = 1:1:700
  
  w = 2*pi*f(a);
  T = R1*C1*j*w/(1+j*w*R1*C1)*(1+R3/R4)/(1+j*w*R2*C2);

  G_dB(a) = 20*log10(abs(T));

endfor

wL = 1/(R1*C1);
wH = 1/(R2*C2);
w0 = (wL*wH)^0.5;

fL = wL/(2*pi);
fH = wH/(2*pi);
f0 = w0/(2*pi);

G_f0 = 20*log10(abs(R1*C1*j*w0/(1+j*w0*R1*C1)*(1+R3/R4)/(1+j*w0*R2*C2)));

hf1 = figure (1);
semilogx(f, G_dB);
xlabel ("f [Hz]");
ylabel ("Gain [dB]");
print(hf1, "gain_dB.eps", "-depsc");

cost = 1.3323*10^4 + 0.440*1 + (R1+R2+R3+R4)/1000;
merit = 1/(abs(R1*C1*j*w0/(1+j*w0*R1*C1)*(1+R3/R4)/(1+j*w0*R2*C2) - 100)*abs(f0 - 1000)*cost)

diary "results_tab.tex"
diary on
printf("$f_L$ & %f\n", fL);
printf("$f_H$ & %f\n", fH);
printf("$f_0$ & %f\n", f0);
printf("$G_{f_0}$ & %f\n", G_f0);
diary off
