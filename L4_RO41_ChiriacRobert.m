clear all
close all
load('lab4_order1_1.mat')
data1=data
t
plot(t,data1.u)
figure
u1ss=0.5
u10=u1ss
y1ss=sum(data1.y([100:129]))/30
y10=y1ss
K1=y1ss/u1ss
t11=9.92
y1max=2.24
y10+0.368*(y1max-y10)
t12=14.08 %aprox,luat de pe grafic
T1=t12-t11
H1=tf([K1],[T1 1])
A1=-1/T1
B1=K1/T1
C1=1
D1=0
H1ss=ss(A1,B1,C1,D1)
Y1=lsim(H1ss,data1.u,t,y10);
plot(t,Y1,'r')
hold on
plot(t,data1.y,'b')
MSE1=1/length(t)*sum((Y1(130:end)-data1.y(130:end)).^2)
%%%%% Ordin 2
%%
figure

load('lab4_order2_1.mat')


data2=data
plot(t,data2.u)
figure
u2ss=1
u20=u2ss
y2ss=sum(data2.y([115:129]))/15
y20=y2ss
K2=y2ss/u2ss
plot(30:130,data2.y(30:130))
figure
Aplus=sum(data2.y([30:49])-y20)
Aminus=sum(y20-data2.y([50:66]))
%cum facem raport putem sa ingoram Ts in formule
M=Aminus/Aplus

tita=log(1/M)/(sqrt(pi^2+(log(M))^2))
T20=(2.65-1.85)*2%valori aproximate din grafic
Wn=2*pi/(T20*sqrt(1-tita^2))
A2=[0 1; -(Wn^2) -2*tita*Wn]
B2=[0;K2*(Wn^2)]
C2=[1 0]
D2=0
H2ss=ss(A2,B2,C2,D2)
Y2=lsim(H2ss,data2.u,t,[y20 0]);
plot(t,Y2)
hold on
plot(t,data2.y)
MSE2=1/length(t)*sum((Y2(130:end)-data2.y(130:end)).^2)
MSE1