clear all
clc

% ContRols are here
bass = 0.99;
mid = 0.01;
treble = 0.99;

% Resistors
Ri = 1e3; % R-in
Ro = 1e6; % R-out
R2 = 33e3; % resistor in stack
T = 220e3;
M = 25e3;
B = 1e6;

% Capacitors
c1 = 470e-12;
c2 = 22e-9;
c3 = 22e-9;


T1 = T*treble;
T2 = T*(1-treble);
B0 = B*bass;
M1 = M*mid;
M2 = M*(1-mid);

% REMEMBER!!!!! This is the laplace for the current in loop d (output loop)
% it needs to be multiplied with Ro to get the output voltage!

% numerator

% s^0
b(1) = 0;

% s^1
b(2) = (B0*c1 + B0*c2 + c1*M1 + c2*M1 + c3*M1 + c1*M2 + c2*M2 + c1*T1);

% s^2
b(3) = (B0*c1*c3*M1 + B0*c2*c3*M1 + c1*c3*M1*M2 + c2*c3*M1*M2 + ...
    B0*c1*c3*R2 + c1*c3*M1*R2 + c1*c2*M2*R2 + c1*c3*M2*R2 + ...
    c1*c3*M1*T1 + c1*c2*M2*T1 + c1*(c2 + c3)*R2*T1 + c1*c3*M1*T2 + ...
    c1*c2*M2*T2 + B0*c1*c2*(R2 + T1 + T2) + ...
    c1*c2*M1*(R2 + T1 + T2));

% s^3
b(4) = (B0*c1*c2*c3*R2*T1 + c1*c2*c3*M2*R2*T1 + ...
   B0*c1*c2*c3*M1*(R2 + T1 + T2) + c1*c2*c3*M1*M2*(R2 + T1 + T2));

% denominator

%s^0
a(1) = B0 + M1 + M2 + Ro + T1;

%s^1
a(2) = (B0*c3*M1 + c3*M1*M2 + B0*c3*Ri + c3*M1*Ri + c1*M2*Ri + c2*M2*Ri + ...
    B0*c3*R2 + c3*M1*R2 + c2*M2*R2 + c3*M1*Ro + c1*M2*Ro + c2*M2*Ro + ...
    c1*Ri*Ro + B0*c1*(Ri + Ro) + c1*M1*(Ri + Ro) + c3*M1*T1 + ...
    c2*M2*T1 + c1*Ri*T1 + c2*(Ri + R2)*(Ro + T1) + ...
    c3*(Ri + R2)*(M2 + Ro + T1) + B0*c2*(Ri + R2 + Ro + T1) + ...
    c2*M1*(Ri + R2 + Ro + T1) + B0*c1*T2 + c1*M1*T2 + c1*M2*T2 + ...
    c1*T1*T2 + c1*Ro*(T1 + T2));

%s^2
a(3) = (B0*c1*c3*M1*Ri + c1*c3*M1*M2*Ri + B0*c1*c3*Ri*R2 + c1*c2*M2*Ri*R2 + ...
	B0*c1*c3*M1*Ro + c1*c3*M1*M2*Ro + B0*c1*c3*Ri*Ro + B0*c1*c3*R2*Ro + ...
	c1*c2*M2*R2*Ro + c1*c2*M2*Ri*T1 + B0*c1*c2*(Ri + Ro)*(R2 + T1) + ...
	c1*c2*M1*(Ri + Ro)*(R2 + T1) + c2*c3*M2*Ri*(Ro + T1) + ...
	c2*c3*M2*R2*(Ro + T1) + B0*c2*c3*(Ri + R2)*(Ro + T1) + ...
	B0*c2*c3*M1*(Ri + R2 + Ro + T1) + c2*c3*M1*M2*(Ri + R2 + Ro + T1) + ...
	B0*c1*c3*M1*T2 + c1*c3*M1*M2*T2 + B0*c1*c3*Ri*T2 + c1*c2*M2*Ri*T2 + ...
	B0*c1*c3*R2*T2 + c1*c2*M2*R2*T2 + c1*c2*M2*T1*T2 + ...
	B0*c1*c2*(Ri + R2 + Ro + T1)*T2 + c1*c2*M1*(Ri + R2 + Ro + T1)*T2 + ...
	c1*(c2 + c3)*Ri*T1*(R2 + T2) + c1*c3*M2*R2*(Ro + T2) + ...
	c1*c3*M2*Ri*(R2 + Ro + T2) + c1*c2*M2*Ro*(T1 + T2) + ...
	c1*(c2 + c3)*Ri*Ro*(R2 + T1 + T2) + ...
	c1*c3*M1*((Ri + Ro)*(R2 + T1) + (Ri + R2 + Ro + T1)*T2) + ...
	c1*(c2 + c3)*R2*(T1*T2 + Ro*(T1 + T2)));

%s^3
a(4) = (B0*c1*c2*c3*Ri*Ro*T1 + c1*c2*c3*M2*Ri*Ro*T1 + ...
	B0*c1*c2*c3*R2*Ro*T1 + c1*c2*c3*M2*R2*Ro*T1 + ...
	B0*c1*c2*c3*M1*(Ri + Ro)*(R2 + T1) + ...
	c1*c2*c3*M1*M2*(Ri + Ro)*(R2 + T1) + B0*c1*c2*c3*Ri*R2*(Ro + T1) + ...
	c1*c2*c3*M2*Ri*R2*(Ro + T1) + B0*c1*c2*c3*Ri*(Ro + T1)*T2 + ...
	c1*c2*c3*M2*Ri*(Ro + T1)*T2 + B0*c1*c2*c3*R2*(Ro + T1)*T2 + ...
	c1*c2*c3*M2*R2*(Ro + T1)*T2 + ...
	B0*c1*c2*c3*M1*(Ri + R2 + Ro + T1)*T2 + ...
	c1*c2*c3*M1*M2*(Ri + R2 + Ro + T1)*T2);

s = tf('s');


sys = Ro*( b(4)*s^3 + b(3)*s^2 + b(2)*s + b(1) ) / ( a(4)*s^3 + a(3)*s^2 + a(2)*s + a(1) )

P = bodeoptions;
XLimMode = 'manual';
P.XLim = [10 30000];
P.FreqUnits = 'Hz'; % Create plot with the options specified by P
h = bodeplot(sys,P);  

sToz3(Ro*b(4),Ro*b(3),Ro*b(2),Ro*b(1),a(4),a(3),a(2),a(1),96000);

