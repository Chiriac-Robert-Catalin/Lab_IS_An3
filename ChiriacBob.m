clear all
close all
load('product_28.mat')
%plot(time,y)
%%%%%%%%%%%% identificare %%%%%%%%%%%%%

%%%%%%%%%%%%% structurare date de indentificare %%%%%%%%%%%
length_y_id=length(y)*80/100
length_time_id=length(time)*80/100
id = struct
for i=1:length_y_id
id.y(i)=y(i)
end
for i=1:length_time_id
id.time(i)=time(i)
end
%%%%%%%%%%%%%
%%%%%%%%%%%% validare %%%%%%%%%%%%%

%%%%%%%%%%%%% structurare date de validare %%%%%%%%%%%

val = struct
a=round(length_y_id)
b=round(length_time_id)
Val_end=length(y)-a;
Timp_end=length(time)-b;
for i=1:Val_end
val.y(i)=y(i+a)
end

for i=1:Timp_end
val.time(i)=time(i+b)
end
%%%%%%%%%

for m= 1:7
O=[];
P=12;
for i = 1:length_time_id
    A=zeros(1,2*m);
    for j = 0:m-1
        A(2*j+1)=cos((2*pi*time(i)*(j+1))/P);
        A(2*j+2)=sin((2*pi*time(i)*(j+1))/P);
    end
    B=[1,time(i),A];
 O(i,:)= B;
end
       
T= O\id.y';
for i =1:length_y_id
    Y(i)=O(i,:)*T;
end
N=length_time_id;
S= 0;
for i=1:N
    S= S+(Y(i)-y(i))^2;
end
MSEID(m)=S/N;
O2=[]
for i = 1:Timp_end
    A2=zeros(1,2*m);
    for j = 0:m-1
        A2(2*j+1)=cos((2*pi*time(i+87)*(j+1))/P);
        A2(2*j+2)=sin((2*pi*time(i+87)*(j+1))/P);
    end
    B2=[1,time(i+87),A2];
 O2(i,:)= B2;
end
for i=1:Val_end
    Y2(i)=O2(i,:)*T;
end
N2=round(length(y)-length_time_id);
S2= 0;
for i=1:N2
    S2= S2+(Y2(i)-y(i+87))^2;
end
MSEVAL(m)=S2/N2
plot(id.time,Y,"b",id.time,id.y,"r")
title("Id=",m);
figure
plot(val.time,Y2,"b",val.time,val.y,"r")
title("Val=",m)
figure
end


plot(MSEID)
title("Eroare ID");
figure

plot(MSEVAL)
title("Eroare Val");
%%%%%%%%%%%%
