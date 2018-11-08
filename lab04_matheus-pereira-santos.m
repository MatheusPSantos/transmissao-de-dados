% Transmissão de dados
% Matheus Pereira dos Santos RA: 1748823

% Observação do efeito Aliasing

%% Exercício 1


N = 5000;    % Número de amostras
fm = 10;    % frequência da mensamgem

%%% fs=200; 
fs=200;               %frequência de amostragem
Ts=1/fs;              %período de amostragem
t=(0:N-1)*Ts;         %vetor do tempo
m = cos(2*pi*fm*t);   %sinal de mensagem

figure
subplot(6,1,1)
plot(t,m,'r--*')
xlim([0 1])
grid on
str1 = ['fs = ' num2str(fs) 'Hz'];   %str1 é um vetor de strings 
ylabel(str1)
% ---------------------
%%% fs = 20 Hz
fs = 20;   % frequência de amostragem
Ts = 1/fs;  % período de amostragem
temp = (0:N-1)*Ts;  % vetor do tempo
m = cos(2*pi*fm*temp);  % sinal de mensagem

subplot(6,1,2)
plot(temp, m, 'g--*')
xlim([0 1])
grid on
str2 = ['fs = ' num2str(fs) 'Hz'];   %str1 é um vetor de strings
ylabel(str2)
%----------------------
%%% fs = 15 Hz
fs = 15;    % frequência de amostragem igual a 15Hz
Ts = 1/fs;  %período de amostragem para a frequência atual
temp = (0: N-1)*Ts;  % vetor de tempo
m = cos(2*pi*fm*temp);  % sinal de mensagem

subplot(6,1,3)
plot(temp, m, 'b--*')
xlim([0 1])
grid on
str3 = ['fs = ' num2str(fs) 'Hz'];  % vetor de strings para legenda
ylabel(str3);
%----------------------
%%% fs = 12Hz
fs = 12;    % frequência de amostragem
Ts = 1/fs;  % novo período de amostragem
temp = (0: N-1)*Ts;  % novo vetor de tempo
% sinal de mensagem
m = cos(2*pi*fm*temp);
% Transformada rápida

subplot(6,1,4)
plot(temp, m, 'r--*')
xlim([0 1])
grid on
str4 = ['fs = ' num2str(fs) 'Hz'];
ylabel(str4);
%-----------------------
%%% fs = 10Hz
% frequência de amostragem e período de amostragem
fs = 10;
Ts = 1/fs;
% vetor do tempo
temp = (0:N-1)*Ts;
%sinal da mensagem e transformada rápida de fourier
m = cos(2*pi*fm*temp);

subplot(6,1,5)
plot(temp, m, 'g--*')
xlim([0 1]);
grid on
str5 = ['fs = ' num2str(fs) 'Hz'];
ylabel(str5);
%-------------------------
%%% fs = 9Hz
% frequência de amostragem e período de amostragem
fs = 9;
Ts = 1/fs;
% vetor de tempo
temp = (0: N-1)*Ts;
% sinal de mensagem
m = cos(2*pi*fm*temp);
subplot(6,1,6)
plot(temp, m, 'b--*')
xlim([0 1]);
grid on
str6 = ['fs = ' num2str(fs) 'Hz'];
ylabel(str6);

xlabel('Tempo');

%% Exercício 2
clear all;
clc;

load audio; %carregando o aúdio

m = m';
fs = 176400;
N = length(m);

%%%% (a) K = 18
k = 18;
fs2 = fs/k;

m2 = m(1: k :end);
N = length(m2);
%%% frequência fs = 176400
Ts = 1/fs;
% vetor de tempo
temp = (0:N-1)*Ts;
tst_impar = mod(N, 2);
    if tst_impar == 1
        N = N+1;
    end
M1 = fft(m)/N;  % transformada rápida de fourier
M = abs(2*M1(1:N/2+1));
f = linspace(0, fs2/2000, N/2+1);

figure
subplot(5,2,1)
plot(temp, m2, 'r');
xlim([0.4 0.41])
grid on
str1 = ['fs = ' num2str(fs2/1000) 'Hz'];
ylabel(str1);
subplot(5,2,2)
fs2x = [fs2/2000 fs2/2000];
fs2y = [0 max(M)];
plot(f,M, 'b--*');
hold on
plot(fs2x, fs2y, 'r--', 'LineWidth', 2)
grid on
xlim([0 6])
%-------------------------
%%% (b) k = 35

k = 35;
fs2 = fs/k;

m2 = m(1: k: end);
N = length(m2);
Ts = 1/fs2;
temp = (0: N-1)*Ts;
tst_impar = mod(N, 2);
    if tst_impar == 1
        N = N+1;
    end
M2 = fft(m2)/N;  % transformada rápida de fourier
M = abs(2*M2(1:N/2+1));
f = linspace(0, fs2/2000, N/2+1);
subplot(5,2,3)
plot(temp, m2, 'g')
xlim([0.4 0.41])
grid on
str2 = ['fs = ' num2str(fs2/1000) 'Hz'];
ylabel(str2);
subplot(5,2,4)
fs2x = [fs2/2000 fs2/2000];
fs2y = [0 max(M)];
plot(f, M, 'g')
hold on
plot(fs2x, fs2y, 'r--', 'LineWidth', 2)
grid on
xlim([0 6])
%-------------------------
%%% (c) k = 70
k = 70;
fs2 = fs/k;
m2 = m(1: k: end);
N = length(m2);
Ts = 1/fs2;
temp = (0:N-1)*Ts;
tst_impar = mod(N, 2);
    if tst_impar == 1
        N = N+1;
    end
M3 = fft(m2)/N;
M = abs(2*M3(1:N/2+1));
f = linspace(0, fs2/2000, N/2+1);
subplot(5,2,5)
plot(temp, m2, 'r')
xlim([0.4 0.41])
grid on
str3 = ['fs = ' num2str(fs2/2000) 'Hz'];
ylabel(str3);
subplot(5,2,6)
fs2x = [fs2/2000 fs2/2000];
fs2y = [0 max(M)];
plot(f, M, 'r')
hold on
plot(fs2x, fs2y, 'b--', 'LineWidth', 2)
grid on
xlim([0 6])
%-----------------------------
%%% (d) k = 140
k = 140;
fs2 = fs/k;
m2 = m(1: k: end);
N = length(m2);
Ts = 1/fs2; % período
temp = (0 : N-1)*Ts; % vetor de tempo
tst_impar = mod(N, 2);
    if tst_impar == 1
        N = N+1;
    end
M4 = fft(m2)/N;
M = abs(2*M4(1:N/2+1));
f = linspace(0, fs2/2000, n/2+1);
subplot(5,2,7);
plot(temp, m2, 'g');
xlim([0.4 0.41]);
grid on
str5 = ['fs = ' num2str(fs2/1000) 'Hz'];
ylabel(str5);
subplot(5,2,8)
fs2x = [fs2/2000 fs2/2000];
fs2y = [0 max(M)];
plot(f, M, 'g')
hold on
plot(fs2x, fs2y, 'r--', 'LineWidth', 2)
grid on
xlim([0 6])
%---------------------------

%%% (e) k = 140 descomentando o filtro passa-baixa anti-aliasing
k = 140;
fs2 = fs2/k;

flp = fs2/2;
filtro = fir1(2000, flp/(fs/2));    % obtenção do filtro em t
mfilt = filter(filtro, 1, m);
m = mfilt;
m2 = m(1: k: end);
N = length(m2);

Ts = 1/fs2;
temp = (0: N-1)*Ts;
tst_impar = mod(N, 2);
    if tst_impar == 1
        N = N+1;
    end
M6 = fft(m2)/N;
M = abs(2*M6(1:N/2+1));
f = linspace(0, fs2/2000, N/2+1);

subplot(5,2,9)
plot(temp, m2, 'b')
xlim([0.4 0.41])
grid on
str6 = ['fs = '  num2str(fs2/1000) 'Hz'];
ylabel(str6);
subplot(5,2,10)
fs2x = [fs2/2000 fs2/2000];
fs2y = [0 max(M)];
plot(f, M, 'b')
hold on
plot(fs2x, fs2y, 'r--', 'LineWidth', 2)
grid on
xlim([0 6])

sound(m, fs)
pause(3)
sound(m2, fs2)
