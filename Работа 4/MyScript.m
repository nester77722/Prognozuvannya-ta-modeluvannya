clear all;
clc;

N=12;
n=N/2;
t=1:N;

Y=[239.5; 289.3; 340.7; 375.3; 393.8; 213.8; 173.4; 221.5; 275.3; 332.3; 430.5; 437.6;]'; %12

Y_half=Y(n+1:N);
Y_sr=Y;
Y_kovz=Y;
k=3;

%метод простих середніх
for i=n:N-1
         Y_sr(i+1)= mean(Y(1:i));
end;
Y_sr=Y_sr(n+1:N);

%метод ковзких середніх (k=3)
for i=n:N-1
         Y_kovz(i+1)= mean(Y(i-k+1:i));
end;
Y_kovz=Y_kovz(n+1:N);

%На 11й
kovz_step1=Y_kovz(1);
sr_step1=Y_sr(1);

%Помилки
e_kovz=Y(N/2+1)-kovz_step1;
e_sr=Y(N/2+1)-sr_step1;

%Абсолютні помилки
delta_kovz=abs(Y(N/2+1)-kovz_step1);
delta_sr=abs(Y(N/2+1)-sr_step1);

%Відносні помилки
eps_kovz=abs(Y(N/2+1)-kovz_step1)/Y(N/2+1);
eps_sr=abs(Y(N/2+1)-sr_step1)/Y(N/2+1);

kovz_step1
e_kovz
delta_kovz
eps_kovz

sr_step1
e_sr
delta_sr
eps_sr

%середня абсолютна помилка
MAE_kovz=0; 
for i=(n+1):N
    MAE_kovz=MAE_kovz+abs(Y(i)-Y_kovz(i-n)); 
end
MAE_kovz=100*MAE_kovz/(n)

MAE_sr=0; 
for i=(n+1):N
    MAE_sr=MAE_sr+abs(Y(i)-Y_sr(i-n)); 
end
MAE_sr=100*MAE_sr/(n)

%середня абсолютна відсоткова помилка прогнозу
MAPE_kovz=0;
for i=(n+1):N
    MAPE_kovz=MAPE_kovz+abs(Y(i)-Y_kovz(i-n))/Y(i);
end
MAPE_kovz=100*MAPE_kovz/(n)

MAPE_sr=0;
for i=(n+1):N
    MAPE_sr=MAPE_sr+abs(Y(i)-Y_sr(i-n))/Y(i);
end
MAPE_sr=100*MAPE_sr/(n)

%середня відсоткова помилка прогнозу
MPE_kovz=0;
for i=(n+1):N
    MPE_kovz=MPE_kovz+(Y(i)-Y_kovz(i-n))/Y(i);
end
MPE_kovz=100*MPE_kovz/(n)

MPE_sr=0;
for i=(n+1):N
    MPE_sr=MPE_sr+(Y(i)-Y_sr(i-n))/Y(i);
end
MPE_sr=100*MPE_sr/(n)

%коефіцієнт детермінації
for i=1:n
error_kovz(i)=Y_half(i)-Y_kovz(i);
error_sr(i)=Y_half(i)-Y_sr(i);
end
R2_kovz = 1 - (cov(Y_half)/cov(error_kovz))
R2_sr = 1 - (cov(Y_half)/cov(error_sr))

plot(t,Y,'-kp',(n+1:N),Y_sr,'-.r+',(n+1:N),Y_kovz,'--b*')
grid on
legend('Y','Ysr','Ykovz')
xlabel('час');
ylabel('Y');