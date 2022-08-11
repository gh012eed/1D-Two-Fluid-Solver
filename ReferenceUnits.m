%all in SI units
z=0.01;
n=1e22;
I=100000;
q=1.60217663e-19;
m=9.1093837e-31;
A=z^2;
u=I/(A*n*q);
t=z/u;
E=m*u/(q*t);
kTe=m*u*u;
kTe_eV=kTe/q;%in eV
F=q*E;

