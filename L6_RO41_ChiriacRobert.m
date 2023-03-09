clear all
close all
clear clc
load('lab6_5.mat')
u=id.u;
y=id.y;
uval=val.u;
yval=val.y;
length(u);
t=1:length(y);
length(uval);
tval=1:length(yval);
%subplot(2,1,1)
%plot((1:length(u)),u)
%subplot(2,1,2)
%plot((1:length(y)),y)
%figure
%subplot(2,1,1)
%plot(tval,uval)
%subplot(2,1,2)
%plot(tval,yval)
%figure
for na=10:10;
for nb=10:10;
N=length(y);
Nval=length(yval);
OP=[];
for i=1:N
    AP=zeros(1,na+nb);
    for j=1:na
        if(i-j<=0)
            AP(j)=0;
        else
            AP(j)=-y(i-j);
        end
    end
    for j=1:nb
        if(i-j<=0)
            AP(j+na)=0;
        else
            AP(j+na)=u(i-j);
        end
    end
    OP(i,:)=AP;
end
OP
tetaP=OP\y
YheadP=zeros(1,length(y));
for i=1:N
    YheadP(i)=OP(i,:)*tetaP;
end
figure
plot(t,y,'g')
hold on
plot(t,YheadP,'b')
title('Predictie ID')
IDMSEP=(1/N)*(sum((YheadP-y').^2))

OPval=[];
for i=1:Nval
    AP=zeros(1,na+nb);
    for j=1:na+1
        if(i-j<=0)
            AP(j)=0;
        else
            AP(j)=-yval(i-j);
        end
    end
    for j=1:nb
        if(i-j<=0)
            AP(j+na)=0;
        else
            AP(j+na)=uval(i-j);
        end
    end
    OPval(i,:)=AP;
end
YheadP=zeros(1,length(y));
for i=1:Nval
    YheadPval(i)=OPval(i,:)*tetaP;
end
figure
plot(tval,yval,'g')
hold on
plot(tval,YheadPval,'b')
title('Predictie val')
VALMSEP=(1/N)*(sum((YheadPval-yval').^2))


YheadS=zeros(1,length(YheadP));
for i=1:N
    AS=zeros(1,na+nb);
    for j=1:na
        if(i-j<=0)
            AS(j)=0;
        else
            AS(j)=-YheadS(i-j);
        end
    end
    for j=1:nb
        if(i-j<=0)
            AS(j+na)=0;
        else
            AS(j+na)=u(i-j);
        end
    end
    length(AS);
    length(tetaP);
    YheadS(i)=AS*tetaP;
end
YheadS;
figure
plot(t,YheadS,'g')
hold on
plot(t,y,'b')
title("Simulare ID")
IDMSES=(1/N)*(sum((YheadS-y').^2))

YheadSval=zeros(1,length(YheadPval));
for i=1:Nval
    ASval=zeros(1,na+nb);
    for j=1:na
        if(i-j<=0)
            ASval(j)=0;
        else
            ASval(j)=-YheadSval(i-j);
        end
    end
    for j=1:nb
        if(i-j<=0)
            ASval(j+na)=0;
        else
            ASval(j+na)=uval(i-j);
        end
    end
    YheadSval(i)=ASval*tetaP;
end
figure
plot(tval,YheadSval,'g')
hold on
plot(tval,yval,'b')
hold on
plot(tval,YheadPval,'r')
legend('Ysim','Y','Ypred')
title("Simulare val")
figure
VALMSES=(1/N)*(sum((YheadSval-yval').^2))
end
end