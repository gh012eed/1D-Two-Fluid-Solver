%all in SI units
z=0.01;
n=1e22;
I=100000;
q=1.60217663e-19;
m=9.1093837e-31;
mp=1.67e-27;%proton mass
mi=40*mp;
Aref=z^2;
uref=I/(Aref*n*q);
tref=z/uref;
Eref=m*uref/(q*tref);
kTe=m*uref*uref;
kTe_eV=kTe/q;%in eV
Fref=q*Eref;
frequency=1/tref;