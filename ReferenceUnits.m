%all in SI units
z=0.01*0.25;%0.25cm
n=1e22;
I=70000;
q=1.60217663e-19;
m=9.1093837e-31;
mp=1.67e-27;%proton mass
Aref=pi*z^2;
uref=I/(Aref*n*q);
tref=z/uref;
Eref=m*uref/(q*tref);
kTe=m*uref*uref;
kTe_eV=kTe/q;%in eV
Fref=q*Eref;
frequency=1/tref;