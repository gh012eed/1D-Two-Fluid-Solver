%define grid points
p=8;
h=2*pi/2^p;
ld=1/2;
dt=h*ld;
z=(-pi+h):h:pi;%excluding z=-pi (periodic boundary condition)
tf=12;
t=0:dt:tf;
N=length(z);
M=length(t);
[Z,T]=meshgrid(z,t);
%parameters
mi=70000;
tauRT=80;
kbar=2*pi;
I=0.7;%current
A0=0.2;%initial area at constricted region
Te0=1/14;
Te=Te0*(1+0*T);%constant Temperature for now
%Te=Te0*exp(T/50);%increasing temperature
n0=1;%initial constant density
u0=(I/(A0*n0));%initial electron drfit velocity before perturbation
Rei0=-350;
epsilon=0.01;%amplitude of small perturbation
%A=A0*(1-epsilon*exp(T/tauRT).*cos(kbar*Z));%harmonic area perturbation
A=A0*(1-epsilon*exp(T/tauRT).*sech(kbar*Z));%dip perturbation
gamma=kbar*u0*sqrt(1/mi);%approximate growth rate of instability at choked region
tau_gamma=1/gamma;%initial growth time of instability
%resistive electric field
Er=-Rei0*(A0./A).*(Te0^(3/2)./Te.^(3/2));
density=ones(M,N);%to store numerical solution for volume density (first index is time, second index is space)
E_field=zeros(M,N);%to store numerical solution for electric field
u_e=zeros(M,N);%to store numerical solution for electron velocity
u_ion=zeros(M,N);%to store numerical solution for ion velocity
%%initial condition for u_ion and density%%
density_0=n0*ones(1,N);
%density_0=density_0-epsilon*n0*cos(kbar*z);%harmonic perturbation
u_ion_0=zeros(1,N);
density(1,:)=density_0;
u_ion(1,:)=u_ion_0;
u_e(1,:)=-I./(density(1,:).*A(1,:));
ue0=max(-1*u_e(1,:));%initial electron drift at constrited region
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

%%evolve the solution using a loop; LF scheme
% for n=1:M-1
%     density(n+1,1)=(density(n,N)+density(n,2))/2-dt/(2*h)*(density(n,2)*u_ion(n,2)-density(n,N)*u_ion(n,N));
%     density(n+1,2:N-1)=(density(n,1:N-2)+density(n,3:N))/2-dt/(2*h)*(density(n,3:N).*u_ion(n,3:N)-density(n,1:N-2).*u_ion(n,1:N-2));
%     density(n+1,N)=(density(n,N-1)+density(n,1))/2-dt/(2*h)*(density(n,1)*u_ion(n,1)-density(n,N-1)*u_ion(n,N-1));
%     u_ion(n+1,1)=(u_ion(n,N)+u_ion(n,2))/2+dt/mi*(E_field(n,1)-Er(n,1))-dt/(4*h)*(u_ion(n,2)^2-u_ion(n,N)^2);
%     u_ion(n+1,2:N-1)=0.5*(u_ion(n,1:N-2)+u_ion(n,3:N))+dt/mi*(E_field(n,2:N-1)-Er(n,2:N-1))-dt/(4*h)*(u_ion(n,3:N).^2-u_ion(n,1:N-2).^2);
%     u_ion(n+1,N)=0.5*(u_ion(n,N-1)+u_ion(n,1))+dt/mi*(E_field(n,N)-Er(n,N))-dt/(4*h)*(u_ion(n,1)^2-u_ion(n,N-1)^2);
%     u_e(n+1,:)=-I./(density(n+1,:).*A(n+1,:));
%     E_field(n+1,1)=Er(n+1,1)-(u_e(n+1,2)^2-u_e(n+1,N)^2)/(4*h)-Te(n+1,1)/(2*h)*(log(density(n+1,2))-log(density(n+1,N)));
%     E_field(n+1,2:N-1)=Er(n+1,2:N-1)-(u_e(n+1,3:N).^2-u_e(n+1,1:N-2).^2)/(4*h)-Te(n+1,2:N-1)/(2*h).*(log(density(n+1,3:N))-log(density(n+1,1:N-2)));
%     E_field(n+1,N)=Er(n+1,N)-(u_e(n+1,1)^2-u_e(n+1,N-1)^2)/(4*h)-Te(n+1,N)/(2*h)*(log(density(n+1,1))-log(density(n+1,N-1)));
% end


%Temperature electric field
E_T=zeros(M,N);
E_T(:,1)=E_field(:,1)-Er(:,1)+(u_e(:,2).^2-u_e(:,N).^2)/(4*h);
E_T(:,2:N-1)=E_field(:,2:N-1)-Er(:,2:N-1)+(u_e(:,3:N).^2-u_e(:,1:N-2).^2)/(4*h);
E_T(:,N)=E_field(:,N)-Er(:,N)+(u_e(:,1).^2-u_e(:,N-1).^2)/(4*h);
%bidirectional electric field
E_B=zeros(M,N);
E_B=E_field-Er;

%calculate potential using trapezoidal rule numerical integration
%setting phi to be zero at z=Nh;
% phi=zeros(M,N);
% for i=(N-1):-1:1
%     phi(:,i)=phi(:,i+1)+(E_field(:,i+1)+E_field(:,i))*h/2;
% end

