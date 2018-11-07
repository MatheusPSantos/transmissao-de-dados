% Transmissão de dados
% Matheus Pereira dos Santos
%% Exercício 1
% Observação do efeito Aliasing
N = 5000;    % Número de amostras
fm = 10;    % frequência da mensamgem

%%% fs=200; 
fs=200;               %frequência de amostragem
Ts=1/fs;              %período de amostragem
t=(0:N-1)*Ts;         %vetor do tempo
m = cos(2*pi*fm*t);   %sinal de mensagem
M1= fft(m)/N;
M= abs(2*M1(1:N/2+1));      %Fourier "one-sided" 
f=linspace(0,fs/2,N/2+1);   %vetor com frequências em Hz

figure
subplot(1,2,1)
plot(t,m,'*-')
xlim([0 1])
grid on
str1 = ['fs = ' num2str(fs)];   %str1 é um vetor de strings 
ylabel(str1)

subplot(1,2,2)
fs2x=[fs/2 fs/2];   %vetores para demonstrar fs/2 na figura
fs2y=[0 max(M)];    %não aparece na primeira figura com fs=200
plot(f,M,fs2x,fs2y,'r--','LineWidth',2)
grid on
xlim([0 20])
% ---------------------
%%% fs = 20 Hz
fs = 20;   % frequência de amostragem
Ts = 1/fs;  % período de amostragem
temp = (0:N-1)*Ts;  % vetor do tempo
m = cos(2*pi*fm*temp);  % sinal de mensagem
M2 = fft(m)/N;
M = abs(2*M2(1:N/2+1)); % Fourier "one-sided"
f1 = linspace(0, fs/2, N/2+1);   % Vetor com frequências em Hz

figure
subplot(1,2,1)
plot(t, m, 'g')
xlim([0 1])
grid on
str1 = ['fs = ' num2str(fs) 'Hz'];   %str1 é um vetor de strings
ylabel(str1)

subplot(1,2,2)
fs2x = [fs/2 fs/2]; %vetores para demonstrar fs/2 na figura
fs2y = [0 max(M)];
plot(f1, M, 'g:', fs2x, fs2y, 'r--', 'LineWidth', 2);
grid on
xlim([0 20])
%----------------------
%%% fs = 15 Hz
fs = 15;    % frequência de amostragem igual a 15Hz
Ts = 1/fs;  %período de amostragem para a frequência atual
temp = (0: N-1)*Ts;  % vetor de tempo
m = cos(2*pi*fm*temp);  % sinal de mensagem
M3 = fft(m)/N; % transformada de fourier rápida
M = abs(2*M3(1:N/2+1)); % Módulo "one-side"
f2 = linspace(0, fs/2, N/2+1);   % Vetor com frequências em Hz

figure
subplot(1,2,1)
plot(t, m, '*-')
xlim([0 1])
grid on
str2 = ['fs = ' num2Str(fs) 'Hz'];  % vetor de strings para legenda
ylabel(str2);

subplot(1,2,2)
fs2x = [fs/2 fs/2]; % vetor para fs/2
fs2y = [0 max(M)];
plot(f2, M, 'r:', fs2x, fs2y, 'g--', 'LineWidth', 2);
grid on
xlim([0 20])



