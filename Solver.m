%define grid points
p=8;
h=2*pi/2^p;
ld=1/2;%try 1/128 will take >an hour 
dt=h*ld;
z=(-pi+h):h:pi;%grid points excluding z=0
tf=50;
t=0:dt:tf;
N=length(z);
M=length(t);
[Z,T]=meshgrid(z,t);
%parameters
mi=70000;
tauRT=100;
kbar=2*pi;
I=0.8;
A0=1;
Te0=0.8;
%Te=Te0*(1+0*exp(T/30));%constant
Te=Te0*exp(T/30);%increasing temperature
n0=0.8;
Rei0=-30;
epsilon=0.05;%amplitude
A=A0*(1-epsilon*exp(T/tauRT).*cos(kbar*Z));%harmonic area perturbation
ue0=I/(n0*A0*(1-epsilon));%initial electron velocity at choked region
gamma=kbar*ue0*sqrt(1/mi)*sqrt(1-Te0/ue0^2);%growth rate of instability
tau_gamma=1/gamma;%initial growth time of instability
%resistive electric field
Er=-Rei0*A0./A.*(Te0^(3/2)./Te.^(3/2));
density=ones(M,N);%to store numerical solution for volume density (first index is time, second index is space)
E_field=zeros(M,N);%to store numerical solution for electric field
u_e=zeros(M,N);%to store numerical solution for electron velocity
u_ion=zeros(M,N);%to store numerical solution for ion velocity
%%initial condition for u_ion and density%%
density_0=n0*ones(1,N);
u_ion_0=zeros(1,N);
density(1,:)=density_0;%initial state of density
u_ion(1,:)=u_ion_0;%initial state of ion velocity
u_e(1,:)=-I./(density(1,:).*A(1,:));
E_field(1,1)=Er(1,1)-(u_e(1,2)^2-u_e(1,N)^2)/(4*h)-Te(1,1)/(2*h)*(log(density(1,2))-log(density(1,N)));
E_field(1,2:N-1)=Er(1,2:N-1)-(u_e(1,3:N).^2-u_e(1,1:N-2).^2)/(4*h)-Te(1,2:N-1)/(2*h).*(log(density(1,3:N))-log(density(1,1:N-2)));
E_field(1,N)=Er(1,N)-(u_e(1,1)^2-u_e(1,N-1)^2)/(4*h)-Te(1,N)/(2*h)*(log(density(1,1))-log(density(1,N-1)));
%%boundary condition is periodic
%%evolve the solution using a loop; FTCS scheme
for n=1:M-1
    density(n+1,1)=density(n,1)-dt/(2*h)*(density(n,2)*u_ion(n,2)-density(n,N)*u_ion(n,N));
    density(n+1,2:N-1)=density(n,2:N-1)-dt/(2*h)*(density(n,3:N).*u_ion(n,3:N)-density(n,1:N-2).*u_ion(n,1:N-2));
    density(n+1,N)=density(n,N)-dt/(2*h)*(density(n,1)*u_ion(n,1)-density(n,N-1)*u_ion(n,N-1));   
    u_ion(n+1,1)=u_ion(n,1)+dt/mi*(E_field(n,1)-Er(n,1))-dt/(4*h)*(u_ion(n,2)^2-u_ion(n,N)^2);
    u_ion(n+1,2:N-1)=u_ion(n,2:N-1)+dt/mi*(E_field(n,2:N-1)-Er(n,2:N-1))-dt/(4*h)*(u_ion(n,3:N).^2-u_ion(n,1:N-2).^2);
    u_ion(n+1,N)=u_ion(n,N)+dt/mi*(E_field(n,N)-Er(n,N))-dt/(4*h)*(u_ion(n,1)^2-u_ion(n,N-1)^2);
    u_e(n+1,:)=-I./(density(n+1,:).*A(n+1,:));
    E_field(n+1,1)=Er(n+1,1)-(u_e(n+1,2)^2-u_e(n+1,N)^2)/(4*h)-Te(n+1,1)/(2*h)*(log(density(n+1,2))-log(density(n+1,N)));
    E_field(n+1,2:N-1)=Er(n+1,2:N-1)-(u_e(n+1,3:N).^2-u_e(n+1,1:N-2).^2)/(4*h)-Te(n+1,2:N-1)/(2*h).*(log(density(n+1,3:N))-log(density(n+1,1:N-2)));
    E_field(n+1,N)=Er(n+1,N)-(u_e(n+1,1)^2-u_e(n+1,N-1)^2)/(4*h)-Te(n+1,N)/(2*h)*(log(density(n+1,1))-log(density(n+1,N-1)));
    
end
% 

%calculate potential using trapezoidal rule numerical integration
%setting phi to be zero at z=Nh;
% phi=zeros(M,N);
% for i=(N-1):-1:1
%     phi(:,i)=phi(:,i+1)+(E_field(:,i+1)+E_field(:,i))*h/2;
% end

