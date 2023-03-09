clear all
close all
%%%%INITIALIZARE%%%%
load('lab10_7')
na=3*n;
nb=na;
uid=id.u;
yid=id.y;
uval=val.u;
yval=val.y;
tetai=zeros(na+nb,1);
P=1000*eye(na+nb,na+nb);
N=length(uid)
for k=1:N
    phi=zeros(1,na+nb);
    for j=1:na
        if k-j<=0
            phi(j)=0;
        else
            phi(j)=-yid(k-j);
        end
    end
    for j=1:nb
        if k-j<=0
            phi(j+na)=0;
        else
            phi(j+na)=uid(k-j);
        end
    end
    e=yid(k)-phi*tetai;
    Pnou=P-(P*(phi)'*phi*P)/(1+phi*P*(phi'));
    W=Pnou*phi';
    teta=tetai+W*e;
    tetai=teta;
    P=Pnou;
    if k==57
        A=teta(1:na);
        C=[1 A'];
        A=C;
        B=teta(na+1:na+nb);
        D=[0 B'];
        B=D;
        model57=idpoly(A,B,1,1,1,0,val.Ts);
    end
end
A=teta(1:na);
C=[1 A'];
A=C;
B=teta(na+1:na+nb);
D=[0 B'];
B=D;
model=idpoly(A,B,1,1,1,0,val.Ts);
compare(model57,val,model);
%teta 57
