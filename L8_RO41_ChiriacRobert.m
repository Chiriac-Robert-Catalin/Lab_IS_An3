clear all
close all
%index 4
load('lab8_4.mat')
%initializare
b0=1
f0=1
delta=1e-3
teta0=[b0;f0]
tetai=teta0;
lmax=300
uid=id.u;
yid=id.y;
uval=val.u;
yval=val.y;
N=length(uid);
t=1:N;
%subplot(2,1,1)
%plot(t,uid)
%subplot(2,1,2)
%plot(t,yid)
%mOE=oe(id,[3 3 1])
alpha=0.5;
fi=f0;
bi=b0;
k=1;
difer=99999;
%algoritm
while (difer>delta && k<lmax) 
eid=zeros(1,N);
for i=1:N
    if(i-1<=0)
        eid(i)=yid(i);
    else
        eid(i)=yid(i)+fi*yid(i-1)-bi*uid(i-1)-fi*eid(i-1);
    end
end
eid;
dfe=zeros(1,N);
dbe=zeros(1,N);
dtetae=zeros(2,N);
for i=1:N
    if(i-1<=0)
       dfe(i)=0;
    else
        dfe(i)=yid(i-1)-fi*dfe(i-1)-eid(i-1);
    end
    if(i-1<=0)
        dbe(i)=0;
    else
        dbe(i)=-uid(i-1)-fi*dbe(i-1);
    end
    dtetae(:,i)=[dbe(i);dfe(i)];
end
dtetae;
DV=eid.*dtetae;
DV2=(2/N)*[sum(DV(1,:));sum(DV(2,:))];
DV=DV2;
DH=(2/N)*((dtetae)*(dtetae)');
inv(DH);
tetanou=tetai-alpha*inv(DH)*DV;
difer=norm(tetanou-tetai);
tetai=tetanou;
fi=tetai(2);
bi=tetai(1);
k=k+1;
end
k
fi
bi
difer
model=idpoly(1,[0,bi],1,1,[1,fi],0,id.Ts)
figure
compare(model,val)