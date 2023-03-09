clear all
close all
load('lab2_10.mat')
MSE=zeros(1,20)
VMSE=zeros(1,20)
for n=1:20 %gradul polinomului
%%generare matrice ID
X=zeros(length(id.X),n);
for i=1:length(id.X) %constanta de timp
A=zeros(1,n);
    for j=0:n-1 % generarea liniei
        nr=id.X(i)^j;
        A(j+1)=nr;
    end
A;
X(i,:)=A;
end
%%calculare tetha
tetha=X\id.Y'
%%generare matrice validare
X2=zeros(length(val.X),n);
for i=1:length(val.X)
A2=zeros(1,n);
    for j=0:n-1
        nr2=val.X(i)^j;
        A2(j+1)=nr2;
    end
A2;
X2(i,:)=A2;
end
%%calculare y aproximat ID
FY=zeros(1,length(id.X));
for i=1:length(id.X)
i;
X(i,:);
tetha;
X(i,:)*tetha;
FY(i)=X(i,:)*tetha;
end
%%calculare IDMSE
MSE(n)=(1/length(id.X))*sum((FY-id.Y).^2);
contor=n
IDMSE=MSE(n)
%%Afisare grafice cele 2 functii pt ID
plot(id.X,id.Y)
hold on
plot(id.X,FY)
title('ID n=',n)
figure
%%calculare y aproximat validare
FY2=zeros(1,length(val.X));
    for i=1:length(val.X)
        FY2(i)=X2(i,:)*tetha;
    end
%%calculare VALMSE
VMSE(n)=(1/length(val.X))*sum((FY2-val.Y).^2);
contor=n
VALMSE=VMSE(n)
%%Afisare grafice cele 2 functii pt Validare
plot(val.X,val.Y)
hold on
plot(val.X,FY2)
title('Val n=',n)
figure
%%incheiere functie mare
end
plot(1:20,MSE)
hold on
plot(1:20,VMSE)
legend("IDMSE","VALMSE")
[valmin,imin]=min(VMSE)