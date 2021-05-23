close all
clear all

%gain stage

VT = 25e-3;
BFN = 178.7;
VAFN = 69.7;
RE1 = 100;
RC1 = 530;
RB1 = 100000;
RB2 = 40000;
VBEON = 0.7;
VCC = 12;
RS = 100; %Rin
RL = 8;

RB = 1/(1/RB1+1/RB2);
VEQ = RB2/(RB1+RB2)*VCC;
IB1 = (VEQ-VBEON)/(RB+(1+BFN)*RE1);
IC1 = BFN*IB1;
IE1 = (1+BFN)*IB1;
VE1 = RE1*IE1;
VO1 = VCC-RC1*IC1;
VCE = VO1-VE1;

gm1 = IC1/VT;
rpi1 = BFN/gm1;
ro1 = VAFN/IC1;

RSB = RB*RS/(RB+RS);

%RE1 a 0 (ver valor que usamos no ngspice)
RE1 = 0;
AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2);
AVI_DB = 20*log10(abs(AV1))

ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)));
ZO1 = 1/(1/ro1+1/RC1)

%RE1 a 100 (ver valor que usamos no ngspice)
RE1 = 100;
%AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2);
%AVI_DB = 20*log10(abs(AV1))

%ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)));
%ZX = ro1*((RSB+rpi1)*RE1/(RSB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RSB)+1/RE1+gm1*rpi1/(rpi1+RSB)));
%ZO1 = 1/(1/ZX+1/RC1)

diary "gain_stage_tab.tex"
diary on
printf("$G_1$ & %f\n", AV1);
printf("${Z1}_{I}$ & %f\n", ZI1);
printf("${Z1}_{O}$ & %f\n", ZO1);
diary off

%output stage
BFP = 227.3;
VAFP = 37.2;
RE2 = 160; %Rout
VEBON = 0.7;
VI2 = VO1;
IE2 = (VCC-VEBON-VI2)/RE2;
IC2 = BFP/(BFP+1)*IE2;
VO2 = VCC - RE2*IE2;

gm2 = IC2/VT;
go2 = IC2/VAFP;
gpi2 = gm2/BFP;
ge2 = 1/RE2;

AV2 = gm2/(gm2+gpi2+go2+ge2)
ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2);
ZO2 = 1/(gm2+gpi2+go2+ge2)

diary "output_stage_tab.tex"
diary on
printf("$G_2$ & %f\n", AV2);
printf("${Z2}_{I}$ & %f\n", ZI2);
printf("${Z2}_{O}$ & %f\n", ZO2);
diary off

%total
gB = 1/(1/gpi2+ZO1);
AV = (gB+gm2/gpi2*gB)/(gB+ge2+go2+gm2/gpi2*gB)*AV1;
AV_DB = 20*log10(abs(AV));
ZI = ZI1;
ZO = 1/(go2+gm2/gpi2*gB+ge2+gB)

Vin = 0.01
rpi2 = 1/gpi2
ro2 = 1/go2

freq = logspace(1, 8, 700);

CI = 730;
CB = 5010;
CO = 2950;

for a = 1:1:700
  
  w=2*pi*freq(a);

  Zci=1/(j*w*CI*10^(-6)); %impedância condensador input

  Zcb=1/(j*w*CB*10^(-6)); %impedância condensador bypass

  Zco=1/(j*w*CO*10^(-6)); %impedância condensador output


  Y = [1, 0, 0, 0, 0, 0, 0;

      -1/RS, 1/RS+1/Zci, -1/Zci, 0, 0, 0, 0;
    
      0, -1/Zci, 1/Zci+1/RB+1/rpi1, -1/rpi1, 0, 0, 0;
    
      0, 0,-gm1-1/rpi1, gm1+1/rpi1 + 1/RE1 + 1/Zcb + 1/ro1, -1/ro1, 0, 0;
    
      0, 0, gm1, -gm1-1/ro1, 1/ro1 + 1/RC1 + 1/rpi2, -1/rpi2, 0;
    
      0, 0, 0, 0, 0, -1/Zco, 1/Zco + 1/RL;
    
      0, 0, 0, 0, -gm2-1/rpi2, gm2 + 1/rpi2 + 1/RE2 + 1/Zco + 1/ro2, -1/Zco];

B = [Vin; 0; 0; 0; 0; 0; 0];

X = Y\B;
	
gain_dB(a) = 20*log10(abs(X(7)/X(1)));

endfor

min = 1

for a = 1:1:700
   if abs(gain_dB(a) - (max(gain_dB) - 3)) < min
     
    min = abs(gain_dB(a) - (max(gain_dB) - 3));

    lco = freq(a);

   endif
endfor
lco

uco = 2.656852*10^6;

bandwidth = uco - lco;

cost = (RS+RL+RC1+RB1+RB2+RE1+RE2)*10^(-3) + (CI+CB+CO) + 2*0.1;

M = abs(AV*bandwidth/(cost*lco));

diary "total_tab.tex"
diary on
printf("$A$ & %f\n", AV);
printf("$Z_I$ & %f\n", ZI);
printf("$Z_O$ & %f\n", ZO);
printf("$Cost$ & %f\n", cost);
printf("$M$ & %f\n", M);
printf("$f_{lower}$ & %f\n", lco);
printf("$f_{upper}$ & %f\n", uco);
printf("$bandwidth$ & %f\n", bandwidth);
diary off

diary "op_tab.tex"
diary on
printf("$V_{BEON}$ & %f\n", VBEON);
printf("$V_{O1}$ & %f\n", VO1);
printf("$V_{CE}$ & %f\n", VCE);
printf("$V_{EBON}$ & %f\n", VEBON);
printf("$V_{O2}$ & %f\n", VO2);
printf("$V_{EC}$ & %f\n", VO2);
diary off

hf1 = figure (1);
semilogx(freq, gain_dB);
xlabel ("f [Hz]");
ylabel ("Gain [dB]");
print(hf1, "gain_dB.eps", "-depsc");
