close all
clear all

f = 50;
A = 230;
R1 = 700*10^3;
R2 = 537.84*10^3;
C = 700*10^(-6);
w = 2*pi*f;
n = 19;
VON = 12/19;
miu = 1;
VT = 26*10^(-3);
IS = 10^(-14);

t=linspace(0, 200e-3, 20000);
vS = A*cos(w*t);

tOFF = 1/w * atan(1/w/R1/C);
vOnexp = A*abs(cos(w*tOFF))*exp(-(t-tOFF)/R1/C);

figure
for i=1:length(t)
  if t(i) < tOFF
    v_Env(i) = abs(vS(i));
  elseif vOnexp(i) > abs(vS(i))
    v_Env(i) = vOnexp(i);
  else
    tOFF = tOFF + 1/(2*f);
    vOnexp = A*abs(cos(w*tOFF))*exp(-(t-tOFF)/R1/C);
    v_Env(i) = abs(vS(i));
  endif
endfor

plot(t*1000, v_Env)
title("Output voltage v_{env}(t)")
xlabel ("t[ms]")
legend("envelope")
print ("v_envelope.eps", "-depsc");

rd = miu*VT/(IS*e^(VON/(miu*VT)));

v_env = v_Env - mean(v_Env);

figure
for i=1:length(t)
  v_out(i) = n*VON + v_env(i)*n*rd/(n*rd+R2);
endfor
plot(t*1000, v_out)
yticks = get (gca, "ytick");
ylabels = arrayfun (@(x) sprintf ("%.6f", x), yticks, "uniformoutput", false);
set (gca, "yticklabel", ylabels);
title("Output voltage v_{out}(t)")
xlabel("t[ms]")
legend("output")
print ("v_output.eps", "-depsc");

figure
plot(t*1000, v_out - 12)
title("Output voltage v_{out}(t) - AC component")
xlabel("t[ms]")
legend("AC output")
print ("v_output_ac.eps", "-depsc");

DC_output = mean(v_out)
ripple = max(v_out) - min(v_out)
cost = (R1+R2)*10^(-3)*1 + C*10^(6)*1 + (4+n)*0.1

diary "results_tab.tex"
diary on
printf("$V_{deviation}$ & %f\n", DC_output - 12);
printf("$V_{ripple}$ & %e\n", ripple);
printf("$cost$ & %f\n", cost);
diary off
