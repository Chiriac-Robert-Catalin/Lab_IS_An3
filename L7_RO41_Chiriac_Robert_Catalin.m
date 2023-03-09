clear all
close all
load("uval.mat")
t=1:length(u)

%index 4
data=system_simulator(4,u)
Us=data.u;
Ys=data.y;
subplot(2,1,1)
plot(t,Us)
subplot(2,1,2)
plot(t,Ys)
na=31;
nb=na;
nk=1;
for m=3:10
if m==3
    L=[1 0 1];
end
if m==4
    L=[1 0 0 1];
end
if m==5
    L=[0 1 0 0 1];
end
if m==6
    L=[1 0 0 0 0 1];
end
if m==7
    L=[1 0 0 0 0 0 1];
end
if m==8
    L=[1 1 0 0 0 0 1 1];
end
if m==9
    L=[0 0 0 1 0 0 0 0 1];
end
if m==10
    L=[0 0 1 0 0 0 0 0 0 1];
end

N=300;
X=ones(1,m);
uid=zeros(1,N);
for i=1:N
    uid(i)=X(m);
    aux=X(1);
    X(1)=mod(sum(L.*X),2);
    for i=m:-1:3
        X(i)=X(i-1);
    end
    X(2)=aux;
end
uid;
%Uid=zeros(1,N)
%Uid(1)=X(m)
%aux=X(1)
%X(1)=mod((L(1)*X(1)+L(2)*X(2)+L(3)*X(3)),2)
%for i=m:-1:2
%
%X(i)=X(i-1)
%X(2)=aux
%end
%Uid(2)=X(m)
a=0.5;
b=1;
Uid=a+(b-a)*uid;
dataid=system_simulator(4,Uid')
model=arx(dataid,[na nb nk])
figure
compare(model,data)
title(m)
PE=2^m-1
end