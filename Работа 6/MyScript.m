clear all;
clc;

A=-2;
B=40;
C=1200;
D=500;

N=60; % всего эл.
t=1:N;
YY=A*(t.^2)+B*t.*sin(t)+C.*rand(1,N)+D;

K=10; % на скільки прогнозуємо
KK=N-K;
Y=YY(1:KK);

Y_fact=YY(KK+1:N); % оставил только 10

data=iddata(Y',[]);
sys1=armax(data,[4 3]);
sys2=armax(data, [4 3], 'IntegrateNoise', 1);
sys3=armax(data,[4,0]);

p1=forecast(sys1,data,K);
p1_znach = p1.OutputData;

p2=forecast(sys2,data,K);
p2_znach = p2.OutputData;

p3 = forecast(sys3, data, K);
p3_znach = p3.OutputData;

figure(1)
[acf, lags] = autocorr(Y);
stem(lags,acf);
grid on

figure(2)
plot(1:KK+K, YY(1:KK+K), '--kp')
grid on
legend('Часовий ряд')
title('Вихідний часовий ряд')


figure(3)
plot(data, '--bo', p1, '--ro')
grid on
legend('Часовий ряд','Прогноз')
title('ARMA [4 3]')

figure(4)
plot(data, '--bo', p2, '--ro')
grid on
legend ('Часовий ряд', 'Прогноз')
title('ARIMA [4 1 3]')

figure(5)
plot(data, '--bo', p3, '--ro')
grid on
legend ('Часовий ряд', 'Прогноз')
title('AR')


% Показники помилок
p1_first=p1_znach(1) %на 11й
p2_first = p2_znach(1)
p3_first = p3_znach(1)
e_p1=YY(KK+1)-p1_znach(1) % Помилка
e_p2=YY(KK+1)-p2_znach(1)
e_p3=YY(KK+1)-p3_znach(1)
delta_p1=abs(YY(KK+1)-p1_znach(1)) % Абсолютна
delta_p2=abs(YY(KK+1)-p2_znach(1))
delta_p3=abs(YY(KK+1)-p3_znach(1))
eps_p1=abs(YY(KK+1)-p1_znach(1))/YY(KK+1) % Відносна
eps_p2=abs(YY(KK+1)-p2_znach(1))/YY(KK+1)
eps_p3=abs(YY(KK+1)-p3_znach(1))/YY(KK+1)

    % середня абсолютна помилка
MAE_p1=0; 
    for i=1:N-KK
        MAE_p1=MAE_p1+abs(Y_fact(i)-p1_znach(i));
    end
    
MAE_p2=0;
    for i=1:N-KK
        MAE_p2=MAE_p2+abs(Y_fact(i)-p2_znach(i));
    end
    
MAE_p3=0; 
    for i=1:N-KK
        MAE_p3=MAE_p3+abs(Y_fact(i)-p3_znach(i));
    end
    % середня абсолютна відсоткова помилка прогнозу
MAPE_p1=0;
for i=1:N-KK
    MAPE_p1=MAPE_p1+abs(Y_fact(i)-p1_znach(i))/Y_fact(i);
end
MAPE_p1=100*MAPE_p1/(N-KK)

MAPE_p2=0;
for i=1:N-KK
    MAPE_p2=MAPE_p2+abs(Y_fact(i)-p2_znach(i))/Y_fact(i);
end
MAPE_p2=100*MAPE_p2/(N-KK)

MAPE_p3=0;
for i=1:N-KK
    MAPE_p3=MAPE_p3+abs(Y_fact(i)-p3_znach(i))/Y_fact(i);
end
MAPE_p3=100*MAPE_p3/(N-KK)
            % середня відсоткова помилка прогнозу
MPE_p1=0;
for i=1:N-KK
    MPE_p1=MPE_p1+(Y_fact(i)-p1_znach(i))/Y_fact(i);
end
MPE_p1=100*MPE_p1/(N-KK)

MPE_p2=0;
for i=1:N-KK
    MPE_p2=MPE_p2+(Y_fact(i)-p2_znach(i))/Y_fact(i);
end
MPE_p2=100*MPE_p2/(N-KK)

MPE_p3=0;
for i=1:N-KK
    MPE_p3=MPE_p3+(Y_fact(i)-p3_znach(i))/Y_fact(i);
end
MPE_p3=100*MPE_p3/(N-KK)
%              коефіцієнт детермінації
for i=1:N-KK
error_p1(i)=Y_fact(i)-p1_znach(i);
end
R2_p1 = 1 - (cov(Y_fact)/cov(error_p1))

for i=1:N-KK
error_p2(i)=Y_fact(i)-p2_znach(i);
end
R2_p2 = 1 - (cov(Y_fact)/cov(error_p2))

for i=1:N-KK
error_p3(i)=Y_fact(i)-p3_znach(i);
end
R2_p3 = 1 - (cov(Y_fact)/cov(error_p3))