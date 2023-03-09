close all
clear all
clear clc
load('lab5_1.mat')
U=id.U;
Y=id.Y;
subplot(3,1,1)
plot(tid,Y)
subplot(3,1,2)
plot(tid,U)
Ud=detrend(U,0);
subplot(3,1,3)
plot(tid,Ud)
% Validare
Uval=val.u;
Yval=val.y;
figure
subplot(2,1,1)
plot(tval,Uval)
subplot(2,1,2)
plot(tval,Yval)
%algoritm
[c,tau]=xcorr(U)
figure
plot(tau,c)
figure
fir=cra(id,130)
%
T=length(U)/2;
N=length(U);
for tau=1:T
    S=0;
    S2=0;
    for i=1:N-tau+1
       S=S+U(i)*U(i+tau-1);
       S2=S2+U(i)*Y(i+tau-1);
    end
    Ru(tau)=S/N;
    Ry(tau)=S2/N;
end
Ru;
Ry;
%am calculat RU si RY
Runou=[fliplr(Ru) Ru];
Runou(1250)=[];
%Am pus in oglinda Ru si am scos 1250 element pt a pune cate M elemente in
%matrice
for M=10:10:130
%Runou(1250:1250+M)
O=zeros(T,M);
for i=1:T
    O(i,:)=Runou((1250-(i-1)):(1250-(i-1)+M-1));
end
%impartiri de matrici
h=O\Ry';
Yhead=conv(h,U);
length(Yhead);
figure;
plot(tid,Y);
hold on
plot(tid,Yhead(1:2500));
title('Id:M=',M)
MSE(M/10)=(1/1250)*sum((Yhead(1:2500)-Y).^2);
%
Yhead2=conv(h,Uval);
figure;
plot(tval,Yval);
length(Yval);
length(Yhead2);
hold on
plot(tval,Yhead2(1:250));
title('Val:M=',M)
VMSE(M/10)=(1/250)*sum((Yhead2(1:250)-Yval).^2);
MSE(M/10);
end
[MinMSE,IminMse]=min(MSE);
[MinVMSE,IminVmse]=min(VMSE);
MidIdeal=IminMse*10
MinMSE
MvalIdeal=IminVmse*10
MinVMSE