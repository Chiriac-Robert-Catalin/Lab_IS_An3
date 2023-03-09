clear all
close all
load('lab2_order1_1')
u1=data.u
y1=data.y
plot(t,u1)

figure
plot(t,y1)
xlim([0 27.72])
figure
%yss=1.56
S=0
for i=90:99
    S=S+y1(i);
end
yss=S/10
y0=0
u0=0
us=0.5
K=(yss-y0)/(us-u0)
minim=999999
kt=0;
tt=0;
for i=1:100
    x=0.632*yss;
    x1=y1(i);
    if(abs(x1-x)<minim)
        minim=abs(x1-x);
        kt=x1;
        tt=t(i);
    end
end
kt
T=tt
yt=0.632*(yss-y0)
H1=tf([K],[T 1])
figure
plot(t,y1)
hold on
yhead =lsim(H1,u1,t)
plot(t,yhead)
xlim([55.44 140])
S=0
for i=201:500
    S=S+(y1(i)-yhead(i))^2;
end
MSE=S/300
%ordin 2
load('lab2_order2_1.mat')
figure
plot(t,data.u)
hold on
plot(t,data.y)
xlim([0 7])
max=0
S=0
for i=90:99
    S=S+data.y(i);
end
yss2=S/10
us2=3
u02=0
y02=0
K2=(yss2-y02)/(us2-u02)
maxover=3.5
M=(maxover-yss2)/yss2

tita=(log(1/M))/(sqrt(pi^2+log(M)^2))
T=(3.57-1.96)*2 %luate de pe grafic max->min cu aproximare
wn=(2*pi)/(T*sqrt(1-tita^2))
H2=tf([K2*(wn^2)],[1 2*tita*wn wn^2])

plot(t,data.u)
figure
plot(t,data.y,'g')
hold on
lsim(H2,data.u,t)