clear all;
clc;

N=12;
n=N/2;
t=1:N;

Y=[239.5; 289.3; 340.7; 375.3; 393.8; 213.8; 173.4; 221.5; 275.3; 332.3; 430.5; 437.6;]'; %12
Y_avg=mean(Y);
a_1=1;
a_3=1;
a_4=0.4;
a_5=0.15;

Y_ez=Y;
Y_ez_2=Y;
Y_ez_3=Y;
Y_ez_4=Y;
Y_ez_5=Y;

for i=(n):N-1
    Y_ez(i+1)=a_1*Y(i)+(1-a_1)*Y_ez(i);
    Y_ez_3(i+1)=a_3*Y(i)+(1-a_3)*Y_ez_3(i);
    Y_ez_4(i+1)=a_4*Y(i)+(1-a_4)*Y_ez_4(i);
    Y_ez_5(i+1)=a_5*Y(i)+(1-a_5)*Y_ez_5(i);
end;

Y_ez=Y_ez(n+1:N);
Y_ez_3=Y_ez_3(n+1:N);
Y_ez_4=Y_ez_4(n+1:N);
Y_ez_5=Y_ez_5(n+1:N);
%ПТ для методу експоненціального згладжування
step_1=Y_ez_3(1)

e_ez=Y(N/2+1)-Y_ez_3
delta_ez=abs(Y(n+1)-Y_ez_3) 
eps_ez=abs(Y(n+1)-Y_ez_3)/Y(n+1) 

%САП
MAE_Y_ez=0;
for i=(n+1):N
    MAE_Y_ez=MAE_Y_ez+abs(Y(i)-Y_ez_3(i-n));
end
MAE_Y_ez=MAE_Y_ez/n

%САВПП
MAPE_Y_ez=0;
for i=(n+1):N
    MAPE_Y_ez=MAPE_Y_ez+abs(Y(i)-Y_ez_3(i-n))/Y(i);
end
MAPE_Y_ez=100*MAPE_Y_ez/(n)

%СВПП
MPE_Y_ez=0;
for i=(n+1):N
    MPE_Y_ez=MPE_Y_ez+abs(Y(i)-Y_ez_3(i-n))/Y(i);
end
MPE_Y_ez=100*MPE_Y_ez/n

%КД
R2_Y_ez=1-(sum((Y(i)-Y_ez_3(i-n)).^2))/(sum((Y(i)-Y_avg).^2))



figure(1)
plot(t,Y,'-kp',(n+1:N),Y_ez,'--g*',(n+1:N),Y_ez_3,'--ro',(n+1:N),Y_ez_4,'--bd',(n+1:N),Y_ez_5,'--m+')
grid on
legend('Y','Yexp.zgl.a=1','Yexp.zgl.a=0,8','Yexp.zgl.a=0,4','Yexp.zgl.a=0,15')
xlabel('час');
ylabel('Y');