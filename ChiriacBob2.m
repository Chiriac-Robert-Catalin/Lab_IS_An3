clear all
close all
load('iddata-06.mat')
a=id.u;
b=id.y;
aval=val.u;
bval=val.y;
na=1;
nb=1;
mmax=6;
IDMSEP=zeros(1,mmax);
IDMSES=zeros(1,   mmax);
VALMSEP=zeros(1,mmax);
VALMSES=zeros(1,mmax);
for m=1:mmax
B=sym('b',[1,na+nb]);

syms S
S=B(1);
for i=2:na+nb
    S=S+B(i);
end
V=[];
for i=1:m
    i;
    X=expand(S^(i-1));
    C=coeffs(X,B(1));
    U=C;
    for j=1:length(C) 
    U(j)=B(1)^(j-1).*(C(j));
    end
    U=flip(U);
    V=[V U];
    
end
V
OP=zeros(2000,sumgauss(m));
for i=1:length(a)
    if i<=1
        NU=subs(V,[B(1) B(2)],[0 0]);
        NU=double(NU);
    else
    NU=subs(V,B,[a(i-1) b(i-1)]);
    NU=double(NU);
    end
    NU;
    OP(i,:)=NU;
end
OP;
tetap=OP\b
%%
BheadP=zeros(1,length(b));
for i=1:length(b)
    BheadP(i)=OP(i,:)*tetap;
end
t=1:length(b);
plot(t,b);
hold on
plot(t,BheadP)
title('Predictie ID')
IDMSEP(m)=(1/length(b))*(sum((BheadP-b').^2))

%%
OPval=zeros(2000,sumgauss(m));
for i=1:length(aval)
    if i<=1
        NU=subs(V,B,[0 0]);
        NU=double(NU);
    else
    NU=subs(V,B,[aval(i-1) bval(i-1)]);
    NU=double(NU);
    end
    NU;
    OPval(i,:)=NU;
end
%%
BheadPval=zeros(1,length(bval));
for i=1:length(bval)
    BheadPval(i)=OPval(i,:)*tetap;
end
figure
tval=1:length(bval);
plot(tval,bval,'g')
hold on
plot(tval,BheadPval,'b')
title('Predictie val')
VALMSEP(m)=(1/length(bval))*(sum((BheadPval-bval').^2))
%%
BheadS=zeros(1,length(BheadP));
for i=1:length(BheadP)
    if i<=1
        NU=subs(V,[B(1) B(2)],[0 0]);
        NU=double(NU);
        BheadS(i)=NU*tetap;
    else
    NU=subs(V,B,[a(i-1) BheadS(i-1)]);
    NU=double(NU);
    BheadS(i)=NU*tetap;
    end
end
figure
%%
plot(t,BheadS,'g')
hold on
plot(t,b,'b')
title("Simulare ID")
IDMSES(m)=(1/length(b))*(sum((BheadS-b').^2))
%%
BheadSval=zeros(1,length(BheadPval));
for i=1:length(bval)
    if i<=1
        NU=subs(V,[B(1) B(2)],[0 0]);
        NU=double(NU);
        BheadSval(i)=NU*tetap;
    else
    NU=subs(V,B,[aval(i-1) BheadSval(i-1)]);
    NU=double(NU);
    BheadSval(i)=NU*tetap;
    end
end
figure
plot(tval,BheadSval,'g')
hold on
plot(tval,bval,'b')
hold on
plot(tval,BheadPval,'r')
legend('Bsim','B','Bpred')
title("Simulare val")
figure
VALMSES(m)=(1/length(bval))*(sum((BheadSval-bval').^2))
end
[iidp,idp]=min(IDMSEP)
[iids,ids]=min(IDMSES)
[ivalp,valp]=min(VALMSEP)
[ivals,vals]=min(VALMSES)
