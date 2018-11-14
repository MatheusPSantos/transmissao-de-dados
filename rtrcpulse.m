function y = rtrcpulse(a,t,T)
%T: Set symbol time
t = t+eps; % Insert offset to prevent NANs
tpi = pi/T; amtpi = tpi*(1-a); aptpi = tpi*(1+a);
ac = 4*a/T; at = 16*a^2/T^2;
y = (sin(amtpi*t)+(ac*t).*cos(aptpi*t))./(tpi*t.*(1-at*t.^2));
y = y/sqrt(T); % Unity energy