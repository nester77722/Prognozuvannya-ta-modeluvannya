clear all;
clc;

%довжина часового ряду, кількість спостережень
N=12;
n=N/2;
t=1:N;

Y=[239.5; 289.3; 340.7; 375.3; 393.8; 213.8; 173.4; 221.5; 275.3; 332.3; 430.5; 437.6;]'; %12
Y_half=Y(n+1:N);

%Наївна модель
for i=(n):N-1
     Y_naive(i+1-n)=Y(i) %наївна
     Y_naive2(i+1-n)=Y(i)+(Y(i)-Y(i-1)) %модифікована 1
     Y_naive3(i+1-n)=Y(i)*(Y(i)/Y(i-1)) %модифікована 2
     Y_naive4(i+1-n)=((Y(i)+Y(i-1))/(Y(i-1)))*((Y(i)+Y(i-1))/4) %сезонні коливання
end

%На 11й
naive_step1=Y_naive(1);
naive2_step1=Y_naive2(1);
naive3_step1=Y_naive3(1);
naive4_step1=Y_naive4(1);

%Помилки
e_naive=Y(N/2+1)-naive_step1;
e_naive2=Y(N/2+1)-naive2_step1;
e_naive3=Y(N/2+1)-naive3_step1;
e_naive4=Y(N/2+1)-naive4_step1;

%Абсолютні помилки
delta_naive=abs(Y(N/2+1)-naive_step1);
delta_naive2=abs(Y(N/2+1)-naive2_step1);
delta_naive3=abs(Y(N/2+1)-naive3_step1);
delta_naive4=abs(Y(N/2+1)-naive4_step1);

%Відносні помилки
eps_naive=abs(Y(N/2+1)-naive_step1)/Y(N/2+1);
eps_naive2=abs(Y(N/2+1)-naive2_step1)/Y(N/2+1);
eps_naive3=abs(Y(N/2+1)-naive3_step1)/Y(N/2+1);
eps_naive4=abs(Y(N/2+1)-naive4_step1)/Y(N/2+1);

%---------- Наївна модель ----------%
naive_step1
e_naive
delta_naive
eps_naive

%середня абсолютна помилка
MAE_naive=0; 
for i=(n+1):N
    MAE_naive=MAE_naive+abs(Y(i)-Y_naive(i-n)); %i-n бо Y_naive поч. з 1
end
MAE_naive=MAE_naive/(n)

%середня абсолютна відсоткова помилка прогнозу
MAPE_naive=0;
for i=(n+1):N
    MAPE_naive=MAPE_naive+abs(Y(i)-Y_naive(i-n))/Y(i);
end
MAPE_naive=100*MAPE_naive/(n)

%середня відсоткова помилка прогнозу
MPE_naive=0;
for i=(n+1):N
    MPE_naive=MPE_naive+(Y(i)-Y_naive(i-n))/Y(i);
end
MPE_naive=100*MPE_naive/(n)

%коефіцієнт детермінації
for i=1:n
error_naive(i)=Y_half(i)-Y_naive(i);
end
R2_naive = 1 - (cov(Y_half)/cov(error_naive))

%---------- Наївна модель (модифікація 1) ----------%
naive2_step1
e_naive2
delta_naive2
eps_naive2

%середня абсолютна помилка
MAE_naive2=0; 
for i=(n+1):N
    MAE_naive2=MAE_naive2+abs(Y(i)-Y_naive2(i-n)); %i-n бо Y_naive поч. з 1
end
MAE_naive2=MAE_naive2/(n)

%середня абсолютна відсоткова помилка прогнозу
MAPE_naive2=0;
for i=(n+1):N
    MAPE_naive2=MAPE_naive2+abs(Y(i)-Y_naive2(i-n))/Y(i);
end
MAPE_naive2=100*MAPE_naive2/(n)

%середня відсоткова помилка прогнозу
MPE_naive2=0;
for i=(n+1):N
    MPE_naive2=MPE_naive2+(Y(i)-Y_naive2(i-n))/Y(i);
end
MPE_naive2=100*MPE_naive2/(n)

%коефіцієнт детермінації
for i=1:n
error_naive2(i)=Y_half(i)-Y_naive2(i);
end
R2_naive2 = 1 - (cov(Y_half)/cov(error_naive2))

%---------- Наївна модель (модифікація 2) ----------%
naive3_step1
e_naive3
delta_naive3
eps_naive3

%середня абсолютна помилка
MAE_naive3=0; 
for i=(n+1):N
    MAE_naive3=MAE_naive3+abs(Y(i)-Y_naive3(i-n)); %i-n бо Y_naive поч. з 1
end
MAE_naive3=MAE_naive3/(n)

% середня абсолютна відсоткова помилка прогнозу
MAPE_naive3=0;
for i=(n+1):N
    MAPE_naive3=MAPE_naive3+abs(Y(i)-Y_naive3(i-n))/Y(i);
end
MAPE_naive3=100*MAPE_naive3/(n)

% середня відсоткова помилка прогнозу
MPE_naive3=0;
for i=(n+1):N
    MPE_naive3=MPE_naive3+(Y(i)-Y_naive3(i-n))/Y(i);
end
MPE_naive3=100*MPE_naive3/(n)

%коефіцієнт детермінації
for i=1:n
error_naive3(i)=Y_half(i)-Y_naive3(i);
end
R2_naive3 = 1 - (cov(Y_half)/cov(error_naive3))

%---------- Наївна модель (сезонні коливання) ----------%
naive4_step1
e_naive4
delta_naive4
eps_naive4

%середня абсолютна помилка
MAE_naive4=0; 
for i=(n+1):N
    MAE_naive4=MAE_naive4+abs(Y(i)-Y_naive4(i-n)); %i-n бо Y_nm поч. з 1
end
MAE_naive4=MAE_naive4/(n)

%середня абсолютна відсоткова помилка прогнозу
MAPE_naive4=0;
for i=(n+1):N
    MAPE_naive4=MAPE_naive4+abs(Y(i)-Y_naive4(i-n))/Y(i);
end
MAPE_naive4=100*MAPE_naive4/(n)

%середня відсоткова помилка прогнозу
MPE_naive4=0;
for i=(n+1):N
    MPE_naive4=MPE_naive4+(Y(i)-Y_naive4(i-n))/Y(i);
end
MPE_naive4=100*MPE_naive4/(n)

%коефіцієнт детермінації
for i=1:n
error_naive4(i)=Y_half(i)-Y_naive4(i);
end
R2_naive4 = 1 - (cov(Y_half)/cov(error_naive4))

plot(t,Y,'-kp',(n+1:N),Y_naive,'-mo',(n+1:N),Y_naive2,'-.rs',(n+1:N),Y_naive3,'-gx',(n+1:N),Y_naive4,'-.y+')
grid on
legend('Y','Ynaiv', 'YnaivM1', 'YnaivM2' )
xlabel('час');
ylabel('Y');