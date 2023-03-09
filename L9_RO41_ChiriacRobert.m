clear all
close all
load('lab9_1.mat');
nb=n;
na=n;
u=id.u;
y=id.y;
model=arx(id,[na,nb,1]);
Ys=sim(model,u);
N=length(Ys);
Z=zeros(na+nb,N);
for i=1:N
    A=zeros(1,na+nb);
    for j=1:na
        if(i-j<=0)
            A(j)=0
        else
            A(j)=-Ys(i-j);
        end
    end
    for j=1:nb
        if(i-j<=0)
            A(j+na)=0
        else
            A(j+na)=u(i-j);
        end
    end
    Z(:,i)=A';
end
Z;
phi=zeros(na+nb,N);
for i=1:N
    A=zeros(1,na+nb);
    for j=1:na
        if(i-j<=0)
            A(j)=0;
        else
            A(j)=-y(i-j);
        end
    end
    for j=1:nb
        if(i-j<=0)
            A(j+na)=0;
        else
            A(j+na)=u(i-j);
        end
    end
    phi(:,i)=A';
end
phi;
S2=Z.*y';
S2=(1/N)*[sum(S2(1,:));sum(S2(2,:));sum(S2(3,:));sum(S2(4,:))]
S1=(1/N)*(Z*phi')
teta=S1\S2
modelIV=idpoly([1 teta(1:n)'],[0 teta(n+1:2*n)'],1,1,1,0,val.Ts)
compare(modelIV,val,model)