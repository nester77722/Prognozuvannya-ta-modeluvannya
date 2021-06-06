clear all;
clc;
N=12;
n=6; nn=n-1;

t=-nn:2:nn;
Y=[239.5; 289.3; 340.7; 375.3; 393.8; 213.8; 173.4; 221.5; 275.3; 332.3; 430.5; 437.6;]'; %12

Y_t=Y(1:n).*t;
t2=t.^2;
Y_t2=Y(1:n).*t2;
t4=t.^4;
sum_Y=sum(Y(1:n));
sum_Y_t=sum(Y_t);
sum_t2=sum(t2);
sum_Y_t2=sum(Y_t2);
sum_t4=sum(t4);

Y_avg=mean(Y);
D=cov(Y);

%ëèí.
a0_LM=sum_Y/n
a1_LM=sum_Y_t/sum_t2
yLM_p=a0_LM+a1_LM*(n)

e_LM=Y(n+1)-yLM_p
delta_LM=abs(Y(n+1)-yLM_p)
eps_LM=abs(Y(n+1)-yLM_p)/Y(n+1)

%ïàðàá.
a2_PM=(n*sum_Y_t2-sum_t2*sum_Y)/(n*sum_t4-sum_t2^2)
a1_PM=sum_Y_t/sum_t2
a0_PM=sum_Y/n-a2_PM*sum_t2/n
yPM_p=a0_PM+a1_PM*(n)+a2_PM*(n).^2

e_PM=Y(n+1)-yPM_p
delta_PM=abs(Y(n+1)-yPM_p)
eps_PM=abs(Y(n+1)-yPM_p)/Y(n+1)

%ýêñï.
A=sum(log(Y(1:n))/n);
B=sum(log(Y(1:n)).*t/sum_t2);
a=exp(A)
b=exp(B)
yEM_p=a*b.^n

e_EM=Y(n+1)-yEM_p
delta_EM=abs(Y(n+1)-yEM_p)
eps_EM=abs(Y(n+1)-yEM_p)/Y(n+1)

i=0;

for t=-nn:2:(nn+N)
    i=i+1;
    yLM(i)=a0_LM+a1_LM*t;
    yPM(i)=a0_PM+a1_PM*t+a2_PM*t^2;
    yEM(i)=a*b^t;
end
t=1:1:N;
%ÑÀÏ
MAE_LM=0;
for i=(n+1):N
    MAE_LM=MAE_LM+abs(Y(i)-yLM(i));
end
MAE_LM=MAE_LM/n

%ÑÀÂÏÏ
MAPE_LM=0;
for i=(n+1):N
    MAPE_LM=MAPE_LM+abs(Y(i)-yLM(i))/Y(i);
end
MAPE_LM=100*MAPE_LM/n

%ÑÂÏÏ
MPE_LM=0;
for i=(n+1):N
    MPE_LM=MPE_LM+abs(Y(i)-yLM(i))/Y(i);
end
MPE_LM=100*MPE_LM/n

%ÊÄ
R2_LM=1-(sum((Y-yLM).^2))/(sum((Y-Y_avg).^2))

%ÑÀÏ
MAE_PM=0;
for i=(n+1):N
    MAE_PM=MAE_PM+abs(Y(i)-yPM(i));
end
MAE_PM=MAE_PM/n

%ÑÀÂÏÏ
MAPE_PM=0;
for i=(n+1):N
    MAPE_PM=MAPE_PM+abs(Y(i)-yPM(i))/Y(i);
end
MAPE_PM=100*MAPE_PM/n

%ÑÂÏÏ
MPE_PM=0;
for i=(n+1):N
    MPE_PM=MPE_PM+abs(Y(i)-yPM(i))/Y(i);
end
MPE_PM=100*MPE_PM/n

%ÊÄ
R2_PM=1-(sum((Y-yPM).^2))/(sum((Y-Y_avg).^2))

%ÑÀÏ
MAE_EM=0;
for i=(n+1):N
    MAE_EM=MAE_EM+abs(Y(i)-yEM(i));
end
MAE_EM=MAE_EM/n

%ÑÀÂÏÏ
MAPE_EM=0;
for i=(n+1):N
    MAPE_EM=MAPE_EM+abs(Y(i)-yEM(i))/Y(i);
end
MAPE_EM=100*MAPE_EM/n

%ÑÂÏÏ
MPE_EM=0;
for i=(n+1):N
    MPE_EM=MPE_EM+abs(Y(i)-yEM(i))/Y(i);
end
MPE_EM=100*MPE_EM/n

%ÊÄ
R2_EM=1-(sum((Y-yEM).^2))/(sum((Y-Y_avg).^2))

figure(1)
plot(t,Y,'--ko')
grid on
legend('Y')

figure(2)
plot(t,Y,'--ko',t,yLM,':b*',t,yPM,'-.rs',t,yEM,'-.go')
grid on
legend('Y','yLM','yPM','yEM')
